//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Brandon Stephens on 6/14/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortType {
        case name, date
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    let filter: FilterType
    @State private var showActionSheet = false
    @State private var currentSort: SortType = .name
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people.sorted {
                return currentSort == .name ?
                    $0.name > $1.name :
                    $0.id > $1.id
            }
        case .contacted:
            return prospects.people.filter { $0.isContacted }.sorted {
                return currentSort == .name ?
                    $0.name > $1.name :
                    $0.id > $1.id
            }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }.sorted {
                return currentSort == .name ?
                    $0.name > $1.name :
                    $0.id > $1.id
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        Image(systemName: prospect.isContacted ? "paperplane.fill" : "paperplane")
                        
                        VStack(alignment: .leading) {
                            
                            Text(prospect.name)
                                .font(.headline)
                            
                            Text(prospect.emailAddress)
                                
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(
                leading: Button(action: {
                    self.showActionSheet = true
                }, label: {
                    Image(systemName: "arrow.up.arrow.down")
                    Text("Sort")
                }),
                trailing: Button(action: {
                    self.isShowingScanner = true
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }))
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "PaulHudson\npaul@hackingwithswift.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Short by"), buttons: [
                    .default(Text("Name")) {
                        self.setSort(.name)
                    },
                    .default(Text("Date")) {
                        self.setSort(.date)
                    },
                ])
            }
        }
    }
    
    func setSort(_ sort: SortType) {
        currentSort = sort
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            //            var dateComponents = DateComponents()
            //            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // for testing
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Doh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
