//
//  CardView.swift
//  Flashzilla
//
//  Created by Brandon Stephens on 6/22/21.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 8)
            
            VStack {
                isShowingAnswer ?
                    Text(card.answer)
                    .font(.title)
                    .foregroundColor(.gray)
                    :
                    Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450,height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        self.removal?()
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewDevice("iPhone12")
    }
}
