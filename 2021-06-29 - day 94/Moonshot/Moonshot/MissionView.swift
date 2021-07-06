//
//  MissionView.swift
//  Moonshot
//
//  Created by Brandon Stephens on 4/16/21.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: {$0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        HStack {
                            Spacer()
                            
                            Image(self.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: scaleIt(v1: fullView, v2: geo))
                                .padding(.top)
                            
                            Spacer()
                        }
                    }
                    
                    Text("Mission Date: \(self.mission.formattedLaunchDate)")
                        .font(.headline)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id:\.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.secondary, lineWidth: 2))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name).font(.headline)
                                    
                                    Text(crewMember.role).foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
                
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    func scaleIt(v1: GeometryProxy, v2: GeometryProxy) -> CGFloat {
        let min: CGFloat = 120
        let max: CGFloat = 360
        let output = 480 * (v2.frame(in: .global).maxY / v1.size.height)
        
        return output > max
            ? max
            : output < min
            ? min
            : output
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts).previewDevice("iPhone 12 mini")
    }
}
