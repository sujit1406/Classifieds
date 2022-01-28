//
//  ClassifiedsExtensions.swift
//  ClassifiedsTests
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import Foundation
@testable import Classifieds

extension Classifieds: Equatable {
    public static func == (lhs: Classifieds, rhs: Classifieds) -> Bool {
        return lhs.name == rhs.name
    }
}
