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
    @State var selectedImageTitle: String = ""
    @State var showDetailedView = false
    
    var columns = [
        GridItem(spacing: 5),
        GridItem(spacing: 5),
        GridItem(spacing: 5)
    ]
    
    init() {
        //Set color for NavigationBarTitle with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(.accentColor)]
        
        //Set color for NavigationBarTitle with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.init(.accentColor)]
    }
    
    var body: some View {
        ScrollView{
            navigationToView()
            LazyVGrid(columns: columns){
                ForEach(gallaryModel.pictureArray, id: \.date){ photo in
                    pictureEnlargedView(url: photo.url, title: photo.title)
                }
            }.padding()
        }.navigationTitle("Nasa Gallary")
            .background(Color.backgroundColor)
    }
    
    /// Picture view from downloaded url
    @ViewBuilder
    func pictureEnlargedView(url: String, title: String) -> some View {
        WebImage(url: URL(string: url))
            .resizable()
            .placeholder(Image("placeholder") )
            .indicator(Indicator.progress)
            .transition(AnyTransition.flipFromLeft)
            .frame(width: 100, height: 100)
            .cornerRadius(5)
            .clipped()
            .onTapGesture {
                selectedImageTitle = title
                showDetailedView = true
            }
            
    }
    
    /// navigate to view
    func navigationToView()-> some View{
        NavigationLink(isActive: $showDetailedView) {
            GallaryDetailView(gallary: gallaryModel, selectedImageTitle: selectedImageTitle)
                .navigationBarTitleDisplayMode(.inline)
        } label: {
        }.hidden()
    }
    
}

struct GallaryGridView_Previews: PreviewProvider {
    static var previews: some View {
        GallaryGridView()
    }
}

