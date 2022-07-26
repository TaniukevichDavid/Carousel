//
//  TileCollectionViewCell.swift
//  Carousel
//
//  Created by David Taniukevich on 25.07.22.
//

import UIKit

struct TileCollectionViewCellViewModel {
    let name: String
    let backgroundColor: UIColor
}

class TileCollectionViewCell: UICollectionViewCell {
    static let identified = "TileCollectionViewCell"
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TileCollectionViewCellViewModel) {
        contentView.backgroundColor = viewModel.backgroundColor
        textLabel.text = viewModel.name
    }
}
