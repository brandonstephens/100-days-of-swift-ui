//
//  Settings.swift
//  Flashzilla
//
//  Created by Brandon Stephens on 6/26/21.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settings: SettingStore
    
    @State private var recycle = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle(isOn: $settings.recycle, label: {Text("Recycle wrong answers")})
                }
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing: Button("Done", action: dismiss))
                .listStyle(GroupedListStyle())
            }
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
