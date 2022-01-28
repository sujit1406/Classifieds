//
//  ClassifiedsAPIProtocol.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import Foundation
import UIKit

protocol ClassifiedsAPIProtocol {
    typealias ClassifiedsCompletionHandler = ([Classifieds], Error?) -> Void
    typealias ImageCompletionHandler = (UIImage?, Error?) -> Void
    var apiEngine: APIEngineProtocol { get set }
    func getClassifieds(completion: @escaping ClassifiedsCompletionHandler)
    func getImage(url:String, completion: @escaping ClassifiedsAPIProtocol.ImageCompletionHandler) 
}
