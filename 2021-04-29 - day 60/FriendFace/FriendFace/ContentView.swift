//
//  ContentView.swift
//  FriendFace
//
//  Created by Brandon Stephens on 4/29/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userStore = UserStore()

    var sortedUsers: [User] {
        userStore.users.sorted {
            $0.name < $1.name
        }
    }
    
    var body: some View {
        NavigationView{
            List(sortedUsers, id: \.id) { user in
                NavigationLink(destination: UserView(store: userStore, id: user.id)) {
                    VStack {
                        Text(user.name)
                            .foregroundColor(user.isActive ? .black : .gray)
                    }
                    
                }
            }
            .navigationBarTitle(Text("🤦‍♀️ FriendFace"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
