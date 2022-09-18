//
//  DateConverter.swift
//  NasaGallary
//
//  Created by Jasvinder Singh on 18/09/22.
//

import Foundation

struct DateConverter {
    /// date format like 2022-09-18
    var dateFormatYYYYMMDD : String {
        "yyyy'-'MM'-'dd'"
    }
    
    /// date format like Sunday, September 18, 2022
    var dateFormatEEEEMMMMDDYYYY : String {
        "EEEE, MMMM dd, yyyy"
    }
    
    /// convert received date string like 2022-09-18 to date object
    func convertReceivedDateStringToDateObject(dateStr: String) -> Date?{
        let receivedDateFormatter = DateFormatter()
        receivedDateFormatter.dateFormat = dateFormatYYYYMMDD
        return receivedDateFormatter.date(from: dateStr)
    }
    
    /// convert date object to desired date string like Sunday, September 18, 2022
    func convertDateObjectToDesiredDateString(date: Date) -> String {
        let showDateFormatter = DateFormatter()
        showDateFormatter.dateFormat = dateFormatEEEEMMMMDDYYYY
        return showDateFormatter.string(from: date)
    }
}
