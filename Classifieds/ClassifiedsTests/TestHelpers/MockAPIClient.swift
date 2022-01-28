//
//  MockAPIClient.swift
//  ClassifiedsTests
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import Foundation
import UIKit
@testable import Classifieds

class MockAPIClient {
    var classifieds = [Classifieds]()

    init() {
        self.classifieds = []
    }

    func getMockClassifieds(completion: @escaping ClassifiedsAPIProtocol.ClassifiedsCompletionHandler) {
        let testBundle = Bundle(for: type(of: self))
        guard let asset = NSDataAsset(name: "Results",bundle: testBundle) else{
            completion([], nil)
            return
        }
        do{
            let data = asset.data
            if let response = try? JSONDecoder().decode(ClassifiedsResponse.self, from: data) {
                print("response.results \(response.results)")
                classifieds = response.results
                completion(classifieds, nil)
            }
        }
        catch{
            completion([], error)
        }
    }
}
