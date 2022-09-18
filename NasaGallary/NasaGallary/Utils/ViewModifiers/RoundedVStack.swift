//
//  RoundedVStack.swift
//  NasaGallary
//
//  Created by Jasvinder Singh on 18/09/22.
//

import SwiftUI

struct RoundedVStack<Content: View>: View {

    let alignment: HorizontalAlignment
    let content: Content
    
    init(alignment: HorizontalAlignment = .center, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.content = content()
    }
    
    var body: some View {
        Group {
            VStack(alignment: self.alignment) {
                content
            }
            .padding()
        }
        .background(Color.roundedVstackColor)
        .cornerRadius(16)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct RoundedContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedVStack {
            Text("Jasvinder")
            Text("Singh")
        }
        .background(.black)
    }
}

