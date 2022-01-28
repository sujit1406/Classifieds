//
//  Classifieds.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import Foundation
struct ClassifiedsResponse: Codable {
    var results: [Classifieds]
}

struct Classifieds: Codable {
    var createdAt: String?
    var price: String?
    var name: String?
    var uid: String?
    var imageIds: [String]?
    var imageUrls: [String]?
    var imageUrlsThumbnails: [String]?

    private enum CodingKeys : String, CodingKey {
        case createdAt = "created_at"
        case price
        case name
        case uid
        case imageIds = "image_ids"
        case imageUrls = "image_urls"
        case imageUrlsThumbnails = "image_urls_thumbnails"
    }

    func getThumbURL() -> String? {
        return self.imageUrlsThumbnails?.last as String?
    }

    func getImageURL() -> String? {
        return self.imageUrls?.last as String?
    }

    func getFormattedDate() -> String{
       return Date.getFormattedDate(string: createdAt ?? "",
                            inputFormat: "yyyy-MM-dd hh:mm:ss.SSSSSS", outputFormat: "dd/MM/yyyy")
    }
}
