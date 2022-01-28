//
//  UITableViewExtensions.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ cell: UITableViewCell.Type) {
        register(UINib(nibName: cell.identifier, bundle: nil), forCellReuseIdentifier: cell.identifier)
    }
    
}
