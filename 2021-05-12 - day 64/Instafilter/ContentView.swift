//
//  ContentView.swift
//  Instafilter
//
//  Created by Brandon Stephens on 5/11/21.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ContentView: View {
    @State private var image: Image?
    @State private var showing = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
          image?
            .resizable()
            .scaledToFit()
            
            Button("Pick image") {
                self.showing = true
            }
        }
        .sheet(isPresented: $showing, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
//        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
