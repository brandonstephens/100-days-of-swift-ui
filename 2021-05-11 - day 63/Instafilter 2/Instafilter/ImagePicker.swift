//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Brandon Stephens on 5/11/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
//    typealias UIViewControllerType = UIImagePickerController // not necessary after you complete the methods
}
