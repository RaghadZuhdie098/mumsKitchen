//
// 
// RecipesCollectionViewCell.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import UIKit
import Combine
import Kingfisher

class RecipesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCell"
    var cancellable = Set<AnyCancellable>()
    var recipe : Recipe? {
        didSet {
            guard let recipe = recipe else {
                return
            }
            //    addSubviews()
            showImage(url: recipe.image ?? "")
            titleLabel.text = recipe.title ?? ""
            //setupCell()
        }
    }
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var imageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Group-2")
        
        return imageView
    }()
    
    let vegetarianLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .yellow.withAlphaComponent(0.7)
        label.text = " vegetarian "
        label.font = .systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    let veganLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .green.withAlphaComponent(0.7)
        label.text = " vegan "
        label.font = .systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    let labelsStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing   = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let imagesStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing   = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var timelabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    var likesLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    var handImageView: UIImageView = {
        let image = UIImage(systemName: "hand.thumbsup")
        let imageView  = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
        imageView.image = image
        return imageView
    }()
    
    var clockImageView: UIImageView = {
        let image = UIImage(systemName: "clock.arrow.circlepath")
        let imageView  = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
        imageView.image = image
        return imageView
    }()
    
    fileprivate func addTitleLabel() {
        self.contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        // titleLabel.heightAnchor.constraint(equalToConstant: recipe?.title?.getHeight(font: .boldSystemFont(ofSize: 15), width: 174) ?? 0)
        // titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        //  titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10).isActive = true
        
    }
    
    fileprivate func addSubviews() {
        addTitleLabel()
        addImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        addSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        //        titleLabel.alpha = 0
        //        imageView.image = nil
        //        imageView.removeFromSuperview()
        //        titleLabel.removeFromSuperview()
        //        labelsStackView.removeFromSuperview()
        //        vegetarianLabel.removeFromSuperview()
        //        veganLabel.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addImageView() {
        let view = UIView()
        view.addSubview(imageView)
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10).isActive = true
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.backgroundColor = .red.withAlphaComponent(0.5)
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        //  imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        // imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    fileprivate func addLabelsStack() {
        if recipe?.vegetarian ?? false {
            labelsStackView.addArrangedSubview(vegetarianLabel)
            vegetarianLabel.translatesAutoresizingMaskIntoConstraints = false
        }
        
        if recipe?.vegan ?? false  {
            labelsStackView.addArrangedSubview(veganLabel)
            veganLabel.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.addSubview(labelsStackView)
        labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
    
    //    func setupCell() {
    //
    //       // addImagesStackView()
    //      //  addTitleLabel()
    //     //   addLabelsStack()
    //    }
    
    func addImagesStackView() {
        if let time = recipe?.cookingMinutes {
            timelabel.text = "\(time) min"
            imagesStackView.addArrangedSubview(clockImageView)
            imagesStackView.addArrangedSubview(timelabel)
        }
        
        if let likes = recipe?.aggregateLikes {
            likesLabel.text = "\(likes)"
            imagesStackView.addArrangedSubview(handImageView)
            imagesStackView.addArrangedSubview(likesLabel)
        }
        
        self.addSubview(imagesStackView)
        imagesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imagesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    func showImage(url:String) {
        let url = URL(string: url)
        imageView.kf.setImage(with: url)
        //Group-2
        
        //        if let imageData = ImageDownloader.images.object(forKey: url as NSString) {
        //            print("Using cache Image")
        //            self.imageView.image = UIImage(data: imageData as Data )
        //            return
        //        }
        //
        //            ImageDownloader.loadImage(from: url)
        //                .receive(on: RunLoop.main)
        //                .sink { image in
        //                    self.imageView.image = image
        //                    if let image = image, let imageData = image.pngData() {
        //                        ImageDownloader.images.setObject(imageData as NSData, forKey: url as NSString)
        //                        print("cache Image")
        //
        //                    }
        //                }.store(in: &cancellable)
        //
        //        }
    }
}







