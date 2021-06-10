//
//  Button.swift
//  Habbit
//
//  Created by Brandon Stephens on 4/22/21.
//

import SwiftUI

struct StyledButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(64)
    }
}

extension Button {
    func styled() -> some View {
        self.modifier(StyledButton())
    }
}


//struct Button_Previews: PreviewProvider {
//    static var previews: some View {
//        StyledButton()
//    }
//}
