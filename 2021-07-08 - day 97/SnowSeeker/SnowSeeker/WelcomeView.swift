//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Brandon Stephens on 7/8/21.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcom to SnowSneeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swip from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
