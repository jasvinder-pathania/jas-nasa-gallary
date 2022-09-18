//
//  GallaryViewModel.swift
//  NasaGallary
//
//  Created by Jasvinder Singh on 18/09/22.
//

import Foundation
import SwiftUI

class GallaryViewModel: ObservableObject{
    @Published var pictureArray: [PictureModel] = []
    
    /// initialization
    init(){
        self.pictureArray = self.readDataFromJsonFile(fileName: "data")
    }
    
    ///read data from json file
     func readDataFromJsonFile(fileName: String) -> [PictureModel]{
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode([PictureModel].self, from: data) {
                return jsonData
            }else{
                return []
            }
        }else{
            return []
        }
    }
    

}
