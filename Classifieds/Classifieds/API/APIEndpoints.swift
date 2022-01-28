//
//  APIEndpoints.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import Foundation

enum APIEndPoints {
    case fetchClassifieds

    func endPoint() -> String {
        switch self {
        case .fetchClassifieds:
            return "/default/dynamodb-writer"
        }
    }
    
    func buildUrl() -> String {
        return "\(AppConstants.API.BaseURL)\(endPoint())"
    }
}
