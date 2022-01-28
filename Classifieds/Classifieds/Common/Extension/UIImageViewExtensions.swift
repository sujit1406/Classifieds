//
//  UIImageViewExtensions.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import UIKit
import SwiftGifOrigin

extension UIImageView {
    
    func setImage(with url: String) {
        guard let imageURL = URL(string: url) else { return }
        setImage(with: imageURL)
    }
    
    private func setImage(with url: URL) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async() {
                self.image = image
            }
        }
        dataTask.resume()
    }
}

extension UIImage {
  public class func gif(asset: String) -> UIImage? {
      if let asset = NSDataAsset(name: asset) {
       return UIImage.gif(data: asset.data)
    }
    return nil
  }
}
