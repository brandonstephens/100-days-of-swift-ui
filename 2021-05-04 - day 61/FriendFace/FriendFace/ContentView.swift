//
//  ContentView.swift
//  FriendFace
//
//  Created by Brandon Stephens on 4/29/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var users: FetchedResults<User>
    
    
    init() {
        // if users is empty then fetch data from server
        if users.count == 0 {
            fetchData()
        }
    }
    
    var body: some View {
        NavigationView{
            List(users, id: \.id) { user in
                VStack {
                    Text(user.id ?? "Empty")
                }
            }
            .navigationBarTitle(Text("🤦‍♀️ FriendFace"))
        }
    }
    
    func fetchData() {
        
        // referenced this for help
        // https://github.com/alexfresneda/100-Days-Of-SwiftUI/blob/4e723164a29fec3ffb7c8fec6b727d8706a6e23c/FriendsList/FriendsList/Users.swift
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedUsers = try decoder.decode([UserData].self, from: data)
                
                DispatchQueue.main.async {
                    //                    self.users = decodedUsers
                    //                    print(decodedUsers)
                    
                    for user in decodedUsers {
//                        print(user.name)
                                                let tempUser = User(context: viewContext)
                                                tempUser.id = user.id
                        //                        tempUser.isActive = user.isActive
                                                tempUser.name = user.name
                        //                        tempUser.age = Int(user.age)
                        //                        tempUser.company = user.company
                        //                        tempUser.email = user.email
                        //                        tempUser.address = user.address
                        //                        tempUser.about = user.about
                        //                        tempUser.registered = user.registered
                        
                                                try? viewContext.save()
                    }
                    
                    // tk save api data to core data
                    
                }
            } catch let error {
                print("Error: \(error)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDevice("iPhone 12")
    }
}
