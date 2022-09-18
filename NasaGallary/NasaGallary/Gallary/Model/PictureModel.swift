//
//  PictureModel.swift
//  NasaGallary
//
//  Created by Jasvinder Singh on 18/09/22.
//

import Foundation

struct PictureModel:  Decodable, Equatable {
    var copyright: String?
    var title: String
    var explanation: String
    var date: String
    var url: String
    var dateObj: Date?
}

extension PictureModel: Identifiable {
    var id: String { return title }
}
