//
//  PictureModel.swift
//  NasaGallary
//
//  Created by Jasvinder Singh on 18/09/22.
//

import Foundation

import SwiftUI

struct PictureModel:  Decodable {
    var copyright: String?
    var title: String
    var explanation: String
    var date: String
    var url: String
}

