//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Stephens on 5/19/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
//        MapView()
//            .edgesIgnoringSafeArea(.all)
        
        VStack {
            if self.isUnlocked {
                Text("🔓 Unlocked")
            } else {
                Text("🔒 Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { succes, authenticationError in
                DispatchQueue.main.async {
                    if succes {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
