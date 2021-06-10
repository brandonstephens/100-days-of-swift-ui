//
//  ContentView.swift
//  Moonshot
//
//  Created by Brandon Stephens on 4/16/21.
//

import SwiftUI

struct ContentView: View {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    @State private var showDates = true
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        Text(showDates
                                ? mission.formattedLaunchDate
                                : mission.crew
                                    .compactMap({$0.name.capitalized})
                                    .joined(separator: ", ")
                        )
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: {
                self.showDates.toggle()
            }) {
                HStack {
                    Image(systemName: "calendar")
                    Text("/")
                    Image(systemName: "person.fill")
                }
            })
            .listStyle(PlainListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
