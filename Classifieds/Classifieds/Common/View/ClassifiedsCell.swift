//
//  ClassifiedsCell.swift
//  Classifieds
//
//  Created by Sujith Antony on 28.01.2022.
//  Copyright © 2022 Classifieds. All rights reserved.
//

import UIKit

class ClassifiedsCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.cornerRadius = 8.0
        thumbImageView.clipsToBounds = true
        loadingIndicator.isHidden = true
    }
    
    func setup(with classifieds: Classifieds) {
        titleLabel.text = classifieds.name
    }

    func updateAppearanceFor(_ image: UIImage?) {
        DispatchQueue.main.async { [unowned self] in
            self.displayImage(image)
        }
    }

    private func displayImage(_ image: UIImage?) {
        if let _image = image {
            loadingIndicator.isHidden = true
            thumbImageView.image = _image
            loadingIndicator.stopAnimating()
        } else {
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            thumbImageView.image = .none
        }
    }
}
