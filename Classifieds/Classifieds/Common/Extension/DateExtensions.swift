//
//  DateExtensions.swift
//  Classifieds
//
//  Created by Sujith Antony on 27/01/2022.
//  Copyright © 2022 Classifieds. All rights reserved.
//

import Foundation

extension Date {

    static func getFormattedDate(string: String , inputFormat:String, outputFormat:String) -> String{
           let dateFormatterGet = DateFormatter()
           dateFormatterGet.dateFormat = inputFormat
           let dateFormatterPrint = DateFormatter()
           dateFormatterPrint.dateFormat = outputFormat
           let date: Date = dateFormatterGet.date(from: string) ?? Date()
           return dateFormatterPrint.string(from: date);
       }
}
