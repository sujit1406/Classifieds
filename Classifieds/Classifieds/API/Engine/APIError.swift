//
//  APIError.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case invalidURL = "The URL is invalid"
    case invalidData = "The data is invalid"
    case invalidResponse = "The response is invalid"
}
