//
//  ImageCache.swift
//  Classifieds
//
//  Created by Sujith Antony on 27/01/2022.
//  Copyright © 2022 Classifieds. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    private init() {}
    static let shared = NSCache<NSString, UIImage>()
}

class ImageDownloader{
    static func downloadImage(_ urlString: String?, completeHandler: @escaping (UIImage?) -> ()) {
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        if let cachedImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image from cache")
            completeHandler(cachedImage)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let _image = UIImage(data: data)
            else { return }
            ImageCache.shared.setObject(_image, forKey: url.lastPathComponent as NSString)
            print("saving Image in cache")
            DispatchQueue.main.async {
                completeHandler(_image)
            }

        }.resume()
    }
}


