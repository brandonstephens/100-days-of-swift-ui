//
//  BucketListApp.swift
//  BucketList
//
//  Created by Brandon Stephens on 5/20/21.
//

import SwiftUI

@main
struct BucketListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserData())
        }
    }
}
