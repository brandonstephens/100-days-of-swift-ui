//
//  PictureView.swift
//  PictureName
//
//  Created by Brandon Stephens on 6/9/21.
//

import SwiftUI

struct PictureView: View {
    var picture: Picture
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(picture.imageName).path)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text(picture.title)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Capsule())
                        .offset(x: -8, y: -8)
                }
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(picture.title), displayMode: .inline)
    }
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView(picture: Picture(id: UUID(), title: "Test", imageName: "example.jpg"))
    }
}
