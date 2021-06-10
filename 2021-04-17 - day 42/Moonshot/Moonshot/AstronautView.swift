//
//  AstronautView.swift
//  Moonshot
//
//  Created by Brandon Stephens on 4/16/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let otherMissions: [Mission]
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        var matches = [Mission]()
        
        for mission in missions {
            for crewMember in mission.crew {
                if crewMember.name == astronaut.id {
                    matches.append(Mission(id: mission.id, launchDate: mission.launchDate, crew: mission.crew, description: mission.description))
                }
            }
        }
        
        self.otherMissions = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .padding(.bottom, 32)
                    
                    Text(self.astronaut.name)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    Text(self.astronaut.description)
                        .padding(.horizontal)
                        .layoutPriority(1)
                    
                    VStack(spacing: 24) {
                        ForEach(self.otherMissions, id:\.id) { mission in
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                
                                VStack(alignment: .leading) {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    
                                    Text(mission.formattedLaunchDate).font(.caption).foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[7])
    }
}
