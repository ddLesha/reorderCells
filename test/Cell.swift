//
//  Cell.swift
//  test
//
//  Created by Alexey Kuznetsov on 09.03.2021.
//

import Foundation
import UIKit

class Cell: UICollectionViewCell {
  
    var imageView: UIImageView!
    var labelView: UILabel!
    static let cellIdentifier = "Cell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        imageView = UIImageView(frame: CGRect.zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5.0
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true

        labelView = UILabel(frame: CGRect.zero)
        labelView.textColor = .white
        labelView.backgroundColor = .gray
        labelView.font = labelView.font.withSize(12)
        
        contentView.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
