//
//
// IngrediantCollectionViewCell.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved.
//


import UIKit

class IngrediantCollectionViewCell: UICollectionViewCell {


    static let identifier = "IngrediantCell"

    var imageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "green-beans-or-string-beans")
        return imageView
    }()

    let titleLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .yellow.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        addImageView()
        addTitleView()
    }

    func addImageView() {
        self.contentView.addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5 ).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }

    func addTitleView() {
        self.contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10 ).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
    }


}
