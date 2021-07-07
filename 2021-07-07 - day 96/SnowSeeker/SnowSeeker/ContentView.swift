//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Brandon Stephens on 7/7/21.
//

import SwiftUI

struct User: Identifiable {
    var id = "Shenanigans"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @Environment(\.horizontalSizeClass) var sizeClass

    
    var body: some View {
        NavigationView {
            NavigationLink(destination:
                            VStack {
                                Text("Secondary").onTapGesture {
                                    self.selectedUser = User()
                                }.alert(item: $selectedUser) { user in
                                    Alert(title: Text(user.id))
                                }
                                
                                Group {
                                    if sizeClass == .compact {
                                        VStack(content: UserView.init)
                                    } else {
                                        HStack(content: UserView.init)
                                    }
                                }
                                
                            }
            ) {
                Text("Hello, world!")
            }
            .navigationBarTitle("Pirmary")
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
