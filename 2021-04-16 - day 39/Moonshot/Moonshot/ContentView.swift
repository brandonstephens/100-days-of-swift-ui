//
//  ContentView.swift
//  Moonshot
//
//  Created by Brandon Stephens on 4/16/21.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Init new CustomText")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "444, Somewhere Ln",
                    "city": "Nashville"
                }
            }
            """
            
            struct User: Codable {
                var name: String
                var address: Address
            }
            
            struct Address: Codable {
                var street: String
                var city: String
            }
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
        
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink(destination: Text("Detail \(row)")) {
//                    Text("Row: \(row)")
//                }
//            }
//            .navigationBarTitle("SwiftUI")
//        }
        
//        ScrollView(.vertical) {
//            VStack(alignment: .leading, spacing: 16) {
//                ForEach(0..<100) {
//                    Text("Item \($0)")
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
        
//        List{
//            ForEach(0..<100) {
//                CustomText("Item \($0)")
//            }
//        }
        
//        VStack(alignment: .center, spacing: 56) {
//            Image("example")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 360, height: 240, alignment: .center)
//                .clipped()
//
//            GeometryReader { geo in
//                Image("example")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: geo.size.width)
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
