//
//  ContentView.swift
//  Flashzilla
//
//  Created by Brandon Stephens on 6/20/21.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                self.offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
        .onEnded { value in
            withAnimation {
                self.isDragging = true
            }
        }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
//        VStack {
//            Text("Ello")
//                .onTapGesture {
//                    print("Text tapped")
//                }
        //        .highPriorityGesture(
        //            TapGesture().onEnded{ _ in
        //                print("VStack tapped")
        //            }
        //        )
//        .simultaneousGesture(
//            TapGesture().onEnded{ _ in
//                print("VStack tapped")
//            }
//        )
        
        
        //        Text("Hello, world!")
        //            .rotationEffect(finalAmount + currentAmount)
        //            .gesture(
        //                RotationGesture()
        //                    .onChanged{ angle in
        //                        self.currentAmount = angle
        //                    }.onEnded{ angle in
        //                        self.finalAmount += self.currentAmount
        //                        self.currentAmount = .degrees(0)
        //                    }
        //            )
        //            .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
        //                print("In progress: \(inProgress)!")
        //            }) {
        //                print("long press")
        //            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
