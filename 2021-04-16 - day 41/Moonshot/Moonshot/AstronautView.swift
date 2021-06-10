//
//  AstronautView.swift
//  Moonshot
//
//  Created by Brandon Stephens on 4/16/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
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
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
