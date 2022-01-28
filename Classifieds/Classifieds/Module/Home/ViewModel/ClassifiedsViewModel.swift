//
//  NowPlayingViewModel.swift
//  Classifieds
//
//  Created by Sujith Antony on 28.01.2022.
//  Copyright © 2022 Classifieds. All rights reserved.
//

import Foundation
import UIKit

class ClassifiedsViewModel {
    
    var apiClient: ClassifiedsAPIProtocol!
    var classifieds: [Classifieds] = []
    
    init(apiClient: ClassifiedsAPIProtocol) {
        self.apiClient = apiClient
    }
    
    func getDataSource(didSelectItemHandler: @escaping ClassifiedsDataSource.ClassifiedsSelectHandler) -> ClassifiedsDataSource {
        return ClassifiedsDataSource(with: classifieds, didSelectItemHandler: didSelectItemHandler)
    }
    
    func getClassifieds(completion: @escaping () -> Void) {
        apiClient.getClassifieds { [weak self] (classifieds, error) in
            if error == nil {
                self?.classifieds = classifieds
            }
            completion()
        }
    }
    
    func getTitle() -> String {
        return "Classifieds"
    }
    
    func numberOfItems() -> Int {
        return classifieds.count
    }
}
