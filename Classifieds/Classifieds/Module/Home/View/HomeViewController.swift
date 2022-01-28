//
//  NowPlayingViewController.swift
//  Classifieds
//
//  Created by Sujith Antony on 28.01.2022.
//  Copyright © 2022 Classifieds. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var loadingImage: UIImageView!
    weak var delegate: ShowDetailsCoordinatorDelegate!
    private var dataSource: ClassifiedsDataSource?
    var viewModel: ClassifiedsViewModel!
    
    convenience init(viewModel: ClassifiedsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        getClassifieds()
    }
    
    //MARK: UI
    private func prepareUI() {
        title = viewModel.getTitle()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        tableview.register(ClassifiedsCell.self)
        dataSource = viewModel.getDataSource(didSelectItemHandler: didSelectClassifieds())
        tableview.dataSource = dataSource
        tableview.delegate = dataSource
        self.tableview.isHidden = true
        loadingImage.image = UIImage.gif(asset: "FadingSquares")
    }
    
    func reloadData() {
        tableview.reloadData()
    }
    
    //MARK: Data

    private func getClassifieds() {
        viewModel.getClassifieds { [weak self] in
            DispatchQueue.main.async {
                self?.dataSource?.updateClassifieds(classifieds: self?.viewModel.classifieds ?? [])
                self?.tableview.isHidden = false
                self?.reloadData()
            }
        }
    }
    
    //MARK: Selection

    private func didSelectClassifieds() -> ClassifiedsDataSource.ClassifiedsSelectHandler {
        return { [weak self] (classified) in
            if let strongSelf = self {
                strongSelf.delegate.showDetails(of: classified, from: strongSelf)
            }
        }
    }
}
