//
//  ClassifiedsDetailsViewController.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    var viewModel: DetailsViewModel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: ShowDetailsCoordinatorDelegate!

    convenience init(viewModel: DetailsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    //MARK: UI
    
    private func prepareUI() {
        title = viewModel.getTitle()
        self.nameLabel.text = viewModel.getTitle()
        self.createLabel.text = viewModel.getCreatedDate()
        self.priceLabel.text = viewModel.getPrice()
        ImageDownloader.downloadImage(viewModel.getItemImage()) { image in
            self.imageView.image = image
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
}
