//
//  ClassifiedsAPIClient.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import Foundation
import UIKit

class ClassifiedsAPIClient: ClassifiedsAPIProtocol {
    var apiEngine: APIEngineProtocol

    init(apiEngine: APIEngineProtocol) {
        self.apiEngine = apiEngine
    }
    
    func getClassifieds(completion: @escaping ClassifiedsAPIProtocol.ClassifiedsCompletionHandler) {
        guard let url = URL(string: APIEndPoints.fetchClassifieds.buildUrl()) else {
            completion([], APIError.invalidURL)
            return
        }
        apiEngine.get(url: url) { (data, error) in
            if let error = error {
                completion([], error)
                return
            }
            guard let data = data else {
                completion([], APIError.invalidData)
                return
            }
            if let response = try? JSONDecoder().decode(ClassifiedsResponse.self, from: data) {
                print("response.results \(response.results)")
                completion(response.results, nil)
                return
            } else {
                completion([], APIError.invalidResponse)
            }
        }
    }

    func getImage(url:String, completion: @escaping ClassifiedsAPIProtocol.ImageCompletionHandler) {
        guard let url = URL(string: url) else {
            completion(nil, APIError.invalidURL)
            return
        }
        apiEngine.get(url: url) { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, APIError.invalidData)
                return
            }
            guard let image:UIImage = UIImage(data: data) else {
                completion(nil, APIError.invalidData)
                return
            }
            completion(image, nil)

        }
    }
}
