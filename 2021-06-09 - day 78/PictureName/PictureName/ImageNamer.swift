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
    
    let locationFetcher = LocationFetcher()
    
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
        .onAppear(perform: self.locationFetcher.start)
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
        var newItem = Picture(
            id: UUID(),
            title: imageStore.name,
            imageName: filename
        )
        
        if let location = self.locationFetcher.lastKnownLocation {
            let newLocation = CodableMKPointAnnotation()
            newLocation.coordinate = location
            newItem.location = newLocation
        } else {
            print("Your location is unknown")
        }
        
        pictureStore.pictures.append(newItem)
        
        print(newItem)
        
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
