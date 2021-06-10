//
//  QuestionsView.swift
//  Edutainment
//
//  Created by Patrick Hill on 3/5/21.
//

import SwiftUI

struct QuestionsView: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment:.leading, spacing: 32) {
                Text("Multiplication Tables")
                    .font(.largeTitle)
                
                
                VStack(alignment:.leading) {
                    Text("How high do you want to go?")
                    Text("\(settings.difficulty, specifier: "%g")")
                    Slider(value: $settings.difficulty, in:1...12, step: 1)
                }
                
                VStack(alignment:.leading) {
                    Text("How many questions do you want?")
                    Text("\(settings.questionCount, specifier: "%g")")
                    Slider(value: $settings.questionCount, in:1...20, step: 1)
                }
                
            }.padding(32)
            
            Spacer()
            
            ButtonCustom(
                text:"Start Game",
                action:{
                    settings.startGame = true
                }
            )
            Spacer()
        }
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView()
    }
}

