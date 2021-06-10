//
//  ImageNamer.swift
//  PictureName
//
//  Created by Brandon Stephens on 6/3/21.
//

import SwiftUI

struct ImageNamer: View  {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var imageStore: InputImage
    @ObservedObject var pictureStore: PictureStore
    
    var body: some View {
        VStack {
            if imageStore.image != nil {
                Image(uiImage: imageStore.image!)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            
            Form {
                Section{
                    TextField("Image name", text: $imageStore.name)
                }
                
                Button(action: {
                    savePicture()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
    
    func savePicture() {
        // write image to docs
        let filename = "\(UUID().uuidString).jpg"
        
        if let image = imageStore.image {
            if let data = image.jpegData(compressionQuality: 0.8) {
                let filename = getDocumentsDirectory().appendingPathComponent(filename)
                try? data.write(to: filename)
            }
        }
        
        // save data to json
        let newItem = Picture(id: UUID(), title: imageStore.name, imageName: filename)
        pictureStore.pictures.append(newItem)
        
        // close sheet
        presentationMode.wrappedValue.dismiss()
    }
}

struct ImageNamer_Previews: PreviewProvider {
    static var previews: some View {
        ImageNamer(imageStore: InputImage(), pictureStore: PictureStore())
            .previewDevice("iPhone 12")
    }
}
