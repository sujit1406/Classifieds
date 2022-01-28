//
//  ClassifiedssDataSource.swift
//  Classifieds
//
//  Created by Sujith Antony on 26.01.2022.
//  Copyright © 2022 Classified. All rights reserved.
//

import UIKit

class ClassifiedsDataSource: NSObject {
    typealias ClassifiedsSelectHandler = (Classifieds) -> ()
    var classifieds: [Classifieds] = []
    var didSelectItemHandler: ClassifiedsSelectHandler?

    func updateClassifieds(classifieds:[Classifieds]){
        self.classifieds = classifieds
    }
    
    init(with classifieds: [Classifieds], didSelectItemHandler: @escaping ClassifiedsSelectHandler) {
        self.classifieds = classifieds
        self.didSelectItemHandler = didSelectItemHandler
    }
}

extension ClassifiedsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classifieds.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassifiedsCell.identifier, for: indexPath) as! ClassifiedsCell
        let classifiedItem = classifieds[indexPath.row]
        cell.setup(with: classifiedItem)
        cell.updateAppearanceFor(.none)

        return cell
    }


}

extension ClassifiedsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let classifiedItem = classifieds[indexPath.row]
        didSelectItemHandler?(classifiedItem)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let classifiedItem = classifieds[indexPath.row]
        ImageDownloader.downloadImage(classifiedItem.getThumbURL()) { image in
            (cell as! ClassifiedsCell).updateAppearanceFor(image)
        }
        ImageDownloader.downloadImage(classifiedItem.getImageURL()) { image in
            // early fetching the detailed image
        }
    }
}
