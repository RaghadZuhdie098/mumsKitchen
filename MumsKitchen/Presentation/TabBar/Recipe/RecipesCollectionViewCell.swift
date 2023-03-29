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

class RecipesCollectionViewCell: UICollectionViewCell {

    static let identifier = "CustomCell"
    var cancellable = Set<AnyCancellable>()
    var recipe : Recipe? {
        didSet {
            guard let recipe = recipe else {
                return
            }
            setupCell()
            showImage(url: recipe.image ?? "")
        }
    }
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()

    lazy var imageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
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
        self.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: imagesStackView.topAnchor, constant: -10).isActive = true
    }

    fileprivate func addSubviews() {
        addImageView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        addSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.alpha = 0
        imageView.image = nil
        labelsStackView.removeFromSuperview()
        vegetarianLabel.removeFromSuperview()
        veganLabel.removeFromSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateLabel() {
        // Set the initial state of the label before the animation
        titleLabel.alpha = 0
        titleLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        // Animate the label to its final state
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveEaseOut], animations: {
            self.titleLabel.alpha = 1
            self.titleLabel.transform = .identity
        }, completion: nil)
    }

    fileprivate func addImageView() {
        let view = UIView()
        self.addSubview(imageView)
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.backgroundColor = .white.withAlphaComponent(0.5)
        imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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

    func setupCell() {
        titleLabel.text = recipe?.title ?? ""
        addImagesStackView()
        addTitleLabel()
        addLabelsStack()
    }

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

        if let imageData = ImageDownloader.images.object(forKey: url as NSString) {
            print("Using cache Image")
            self.imageView.image = UIImage(data: imageData as Data )
            return
        }

            ImageDownloader.loadImage(from: url)
                .receive(on: RunLoop.main)
                .sink { image in
                    self.imageView.image = image
                    if let image = image, let imageData = image.pngData() {
                        ImageDownloader.images.setObject(imageData as NSData, forKey: url as NSString)
                        print("cache Image")

                    }
                }.store(in: &cancellable)

        }
    }








