//
//  UserView.swift
//  FriendFace
//
//  Created by Brandon Stephens on 5/1/21.
//

import SwiftUI

struct UserView: View {
    var store: UserStore
    var id: UUID
    
    var currentUser: User? {
        store.findById(id: id) ?? nil
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text(currentUser?.name ?? "Missing Data")
                            .font(.title)
                            .fontWeight(.black)
                        
                        Spacer()
                        
                        if currentUser?.age ?? 0 > 0 {
                            Text("\(currentUser!.age) y/o")
                        }
                    }
                    
                    Text("\(currentUser?.isActive ?? false ? "Active" : "Not Active")")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .foregroundColor(currentUser?.isActive ?? false ? .white : .black)
                        .background(currentUser?.isActive ?? false ? Color.green : Color.gray.opacity(0.4))
                        .clipShape(Capsule())
                }
                .padding(.horizontal)
                
                Text(currentUser?.about ?? "Missing Data")
                    .font(.body)
                    .padding(.horizontal)
                
                HStack {
                    Image(systemName: "envelope")
                    
                    Text(currentUser?.email ?? "Missing Data")
                        .font(.subheadline)
                }
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "briefcase")
                    
                    Text(currentUser?.company ?? "Missing Data")
                        .font(.subheadline)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "person.3")
                        
                        Text("Friends:").font(.subheadline)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        ForEach(currentUser?.friends ?? [], id: \.self) { friend in
                            NavigationLink(destination: UserView(store: store, id: friend.id)){
                                HStack {
                                    Text(friend.name)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Image(systemName: "tag")
                    
                    Text("Tags:").font(.subheadline)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    ForEach(currentUser?.tags ?? [], id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
