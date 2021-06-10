//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Stephens on 5/18/21.
//

import SwiftUI

struct ContentView: View {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
        
        return paths[0]
    }
    
    var body: some View {
        Text("foo")
            .onTapGesture {
                let str = "Have you heard the message?"
                let url = self.getDocumentsDirectory()
                    .appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
