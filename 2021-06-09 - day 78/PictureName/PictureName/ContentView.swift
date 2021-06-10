//
//  ContentView.swift
//  PictureName
//
//  Created by Brandon Stephens on 6/2/21.
//

import SwiftUI

// https://www.hackingwithswift.com/guide/ios-swiftui/6/3/challenge

// -[x] Wrap UIImagePickerController so it can be used to select photos.
// -[x] Detect when a new photo is imported, and immediately ask the user to name the photo.
// -[x] Save that name and photo somewhere safe.
// -[x] Show all names and photos in a list, sorted by name.
// -[x] Create a detail screen that shows a picture full size.
// -[x] Decide on a way to save all this data. (json in documents?)

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var showingImageNamer = false
    
    @ObservedObject var pictureStore = PictureStore()
    @ObservedObject var imageStore = InputImage()
    
    func removePicture(at offsets: IndexSet) {
        pictureStore.pictures.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(pictureStore.pictures) { picture in
                        NavigationLink(destination: PictureView(picture: picture)) {
                            HStack {
                                Image(uiImage: UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(picture.imageName).path)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                Text(picture.title)
                                
                                if picture.location != nil {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: removePicture)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle(Text("PicTors"), displayMode: .large)
            .navigationBarItems(trailing: Button( action: {
                self.showingImagePicker = true
            }) {
                Image(systemName: "plus.square")
                    .font(.title)
            })
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $imageStore.image)
        }
        .sheet(isPresented: $showingImageNamer) {
            ImageNamer(imageStore: imageStore, pictureStore: pictureStore)
        }
    }
    
    func loadImage() {
        guard let image = imageStore.image else { return }
        imageStore.image = image
        self.showingImageNamer = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}
