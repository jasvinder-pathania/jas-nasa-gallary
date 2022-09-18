//
//  GallaryGridView.swift
//  NasaGallary
//
//  Created by Jasvinder Singh on 18/09/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GallaryGridView: View {
    @StateObject var gallaryModel = GallaryViewModel()
    
    var columns = [
        GridItem(spacing: 5),
        GridItem(spacing: 5),
        GridItem(spacing: 5)
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns){
                ForEach(gallaryModel.pictureArray, id: \.date){ photo in
                    pictureEnlargedView(url: photo.url, title: photo.title)
                }
            }.padding()
        }
    }
    
    /// Picture view from downloaded url
    @ViewBuilder
    func pictureEnlargedView(url: String, title: String) -> some View {
        WebImage(url: URL(string: url))
            .resizable()
            .indicator(Indicator.progress)
            .transition(AnyTransition.flipFromLeft)
            .frame(width: 100, height: 100)
            .cornerRadius(5)
            .clipped()
    }
}

struct GallaryGridView_Previews: PreviewProvider {
    static var previews: some View {
        GallaryGridView()
    }
}
