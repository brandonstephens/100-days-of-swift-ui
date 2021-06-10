//
//  InputImage.swift
//  PictureName
//
//  Created by Brandon Stephens on 6/9/21.
//


import SwiftUI

class InputImage: ObservableObject {
    @Published var image: UIImage?
    @Published var name = ""
}
