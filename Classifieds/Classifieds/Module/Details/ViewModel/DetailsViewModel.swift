//
//  ClassifiedsDetailsViewModel.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewModel {
    private var currentClassifieds: Classifieds!
    init(item: Classifieds) {
        self.currentClassifieds = item
    }

    func getTitle() -> String {
        return self.currentClassifieds.name ?? "Item"
    }

    func getPrice() -> String {
        return self.currentClassifieds.price ?? "0"
    }

    func getCreatedDate() -> String {
        return self.currentClassifieds.getFormattedDate()
    }

    func getItemImage() -> String? {
        return self.currentClassifieds.getImageURL()
    }
}
