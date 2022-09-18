//
//  GallaryDetailView.swift
//  NasaGallary
//
//  Created by Jasvinder Singh on 18/09/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GallaryDetailView: View {
    @ObservedObject var gallary = GallaryViewModel()
    @State var selectedImageTitle: String
    
    var body: some View {
        VStack{
            picturePaginationView()
        }.onAppear {
            self.getDataforGallaryViewModel(item: selectedImageTitle)
        }
        .background(Color.backgroundColor)
        .animation(.easeInOut(duration: 0.5), value: self.gallary.currentIndex)
    }
    
    /// picture pagination view creation
    @ViewBuilder
    func picturePaginationView() -> some View {
        TabView(selection: $selectedImageTitle) {
            ForEach(gallary.pictureArray, id: \.title){ photo in
                self.pictureEnlargedView(url: photo.url, title: photo.title)
            }
        }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            .onChange(of: selectedImageTitle) { imageName in
                self.getDataforGallaryViewModel(item: imageName)
            }
        self.detailedInformationView()
    }
    
    /// Picture view from downloaded url
    @ViewBuilder
    func pictureEnlargedView(url: String, title: String) -> some View {
        WebImage(url: URL(string: url))
            .resizable()
            .placeholder(Image("placeholder") )
            .indicator(Indicator.progress)
            .transition(AnyTransition.flipFromLeft)    .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.width, alignment: .center)
            .tag(title)
            .clipped()
    }
    
    /// Detailed information Views
    @ViewBuilder
    func detailedInformationView() -> some View {
            self.headers()
            self.detailedBody()
    }
    
    /// Header information view like title, date and copywrite
    @ViewBuilder
    func headers() -> some View {
        RoundedVStack{
            if let photoObj = gallary.currentPictureObject{
                HStack{
                    Text(photoObj.title).font(.title2)
                    Text("|").font(.footnote)
                    Text(photoObj.date).font(.body)
                }.foregroundColor(.textColor)
                if let copyright = photoObj.copyright {
                    Text("© " + copyright).font(.footnote)
                        .foregroundColor(.textColor)
                }
            }
        }
    }
    
    /// explanation text view of picture
    @ViewBuilder
    func detailedBody() -> some View {
        ScrollView{
            RoundedVStack{
                if let photoObj = gallary.currentPictureObject{
                    Text(photoObj.explanation).font(.footnote)
                }
            }
        }
    }
    
    func getDataforGallaryViewModel(item: String) {
        self.gallary.currentPictureObject = self.gallary.getCurrentPictureObject(imageTitle: item)
        self.gallary.currentIndex = self.gallary.getIndexOfCurrentPictureObject(item: self.gallary.currentPictureObject)
    }
    
}

struct GallaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GallaryDetailView(selectedImageTitle: "")
    }
}

