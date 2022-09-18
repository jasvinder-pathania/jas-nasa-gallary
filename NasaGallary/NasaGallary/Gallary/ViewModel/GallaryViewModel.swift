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
    @Published var currentPictureObject: PictureModel?
    @Published var currentIndex = 0
    
    /// initialization
    init(){
        if let fileData = self.readDataFromJsonFile(fileName: "data") {
            self.pictureArray = fileData
        }
        self.dateFormatConversion()
        self.sortByLatestDate()
    }
    
    ///read data from json file
     func readDataFromJsonFile(fileName: String) -> [PictureModel]?{
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode([PictureModel].self, from: data) {
                return jsonData
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    /// date format conversion to set date object
     func dateFormatConversion() {
         let dateConverter = DateConverter()
        for (index, photo) in self.pictureArray.enumerated() {
            if let date = dateConverter.convertReceivedDateStringToDateObject(dateStr: photo.date){
                self.pictureArray[index].date = dateConverter.convertDateObjectToDesiredDateString(date: date)
                self.pictureArray[index].dateObj = date
            }
        }
    }
    
    /// sorting pictures by latest date
    func sortByLatestDate(){
        self.pictureArray = self.pictureArray.sorted {$0.dateObj! > $1.dateObj!}
    }
    
    /// getting current picture object from the list
    func getCurrentPictureObject(imageTitle: String) {
        self.currentPictureObject = self.pictureArray.filter{ $0.title == imageTitle }.first
    }
    
    /// getting selected picture object index from the list
    func getIndexOfCurrentPictureObject() {
        self.currentIndex = self.pictureArray.firstIndex(where: {$0 == self.currentPictureObject}) ?? 0
    }

}
