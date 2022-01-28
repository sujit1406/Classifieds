//
//  AppCoordinator.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.

import UIKit

protocol ShowDetailsCoordinatorDelegate: class {
    func showDetails(of classified: Classifieds, from viewController: UIViewController)
}

class AppCoordinator: AppCoordinatorProtocol {
    
    var rootViewController: UINavigationController!
    var apiEngine: APIEngine!
    let apiClient: ClassifiedsAPIClient!
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        apiEngine = APIEngine()
        apiClient = ClassifiedsAPIClient(apiEngine: apiEngine)
    }
    
    func start() {
        guard let window = window else { return }
        
        rootViewController = UINavigationController(rootViewController: getHomeViewController())
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func getHomeViewController() -> HomeViewController {
        let viewModel = ClassifiedsViewModel(apiClient: apiClient)
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
}

extension AppCoordinator: ShowDetailsCoordinatorDelegate {
    
    func showDetails(of item: Classifieds, from viewController: UIViewController) {
        let viewModel = DetailsViewModel(item: item)
        let classifiedDetailController = ItemDetailsViewController(viewModel: viewModel)
        classifiedDetailController.delegate = self
        viewController.show(classifiedDetailController, sender: nil)
    }
}
