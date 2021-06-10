//
//  ButtonCustom.swift
//  Edutainment
//
//  Created by Patrick Hill on 3/5/21.
//

import SwiftUI


struct ButtonCustom: View {
    var text: String
    var color: Color = Color.blue
    var action: () -> Void
    
    var body: some View {
        Button(action:{
            self.action()
        }) {
            Text(self.text)
                .padding(.vertical,16)
                .padding(.horizontal,32)
                .background(color)
                .foregroundColor(Color.white)
                .cornerRadius(200)
                .padding(.horizontal,32)
        }
    }
}
