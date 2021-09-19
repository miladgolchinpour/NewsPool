//
//  LetterImage.swift
//  LetterImage
//
//  Created by Milad Golchinpour on 9/19/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

struct LetterImage: View {
    var letter: Character
    
    let colors = [Color.red, .blue, .brown, .green, .indigo, .mint, .orange, .pink, .yellow, .teal, .purple]
    
    var body: some View {
        Text(letter.description)
            .font(.title3)
            .fontWeight(.black)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(colors.randomElement()?.cornerRadius(10))
    }
}

struct LetterImage_Previews: PreviewProvider {
    static var previews: some View {
        LetterImage(letter: "A")
    }
}
