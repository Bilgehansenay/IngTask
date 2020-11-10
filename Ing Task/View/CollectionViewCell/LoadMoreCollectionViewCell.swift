//
//  LoadMoreCollectionViewCell.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 7.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import UIKit

class LoadMoreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var loadMoreButton: UIButton!
    weak var loadMoreDelegate: LoadMoreCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadMoreButton.corneredRadius(radius: 5)

    }

    @IBAction func loadMoreButtonTapped(_ sender: Any) {
        loadMoreDelegate?.LoadMore()
    }
    
    
}

protocol LoadMoreCollectionViewCellDelegate: class {
    func LoadMore()

}
