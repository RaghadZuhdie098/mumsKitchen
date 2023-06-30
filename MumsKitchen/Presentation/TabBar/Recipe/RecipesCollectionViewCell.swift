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
            setupCell()
            showImage(url: recipe.image ?? "")
            titleLabel.text = recipe.title ?? ""
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
    
    let timeStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing   = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let likesStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
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
    }
    
    fileprivate func addSubviews() {
        addTitleLabel()
        addImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        backgroundColor = .yellow.withAlphaComponent(0.3)
        addSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        labelsStackView.removeFromSuperview()
        vegetarianLabel.removeFromSuperview()
        veganLabel.removeFromSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addImageView() {

        let viewUnderImage = UIView()
        viewUnderImage.addSubview(imageView)
        self.contentView.addSubview(viewUnderImage)
        viewUnderImage.backgroundColor = .blue.withAlphaComponent(0.4)
        viewUnderImage.translatesAutoresizingMaskIntoConstraints = false
        viewUnderImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        viewUnderImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        viewUnderImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        viewUnderImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        viewUnderImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10).isActive = true

        imageView.topAnchor.constraint(equalTo: viewUnderImage.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: viewUnderImage.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: viewUnderImage.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: viewUnderImage.bottomAnchor, constant: -2).isActive = true

        let viewAboveImage = UIView()
        self.contentView.addSubview(viewAboveImage)
        viewAboveImage.translatesAutoresizingMaskIntoConstraints = false
        viewAboveImage.backgroundColor = .white.withAlphaComponent(0.4)
        viewAboveImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        viewAboveImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        viewAboveImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        viewAboveImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        viewAboveImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10).isActive = true

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

        addImagesStackView()
        addLabelsStack()

    }
    
    func addImagesStackView() {

        if let time = recipe?.cookingMinutes {
            timelabel.text = "\(time) min"
            timeStackView.addArrangedSubview(clockImageView)
            timeStackView.addArrangedSubview(timelabel)
        }
        
        if let likes = recipe?.aggregateLikes {
            likesLabel.text = "\(likes)"
            likesStackView.addArrangedSubview(handImageView)
            likesStackView.addArrangedSubview(likesLabel)
        }

        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false

        let centeredStack = UIStackView()
        centeredStack.translatesAutoresizingMaskIntoConstraints = false
        centeredStack.spacing   = 5
        centeredStack.alignment = .center
        centeredStack.axis = .horizontal
        centeredStack.distribution = .equalCentering

        centeredStack.addArrangedSubview(timeStackView)
        centeredStack.addArrangedSubview(likesStackView)
        view.addSubview(centeredStack)
        self.contentView.addSubview(view)

        view.heightAnchor.constraint(equalToConstant: 27).isActive = true
        view.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0 ).isActive = true
        view.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: 0).isActive = true

        centeredStack.translatesAutoresizingMaskIntoConstraints = false
        centeredStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        centeredStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        centeredStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centeredStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10).isActive = true
        centeredStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func showImage(url:String) {
        
        
        imageView.kf.setImage(with: URL(string: url)!)
//        if let imageData = ImageDownloader.images.object(forKey: url as NSString) {
//            print("Using cache Image")
//            self.imageView.image = UIImage(data: imageData as Data )
//            return
//        }

//        ImageDownloader.loadImage(from: url)
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    // Handle the error
//                    print("Error loading image: \(error.localizedDescription)")
//                case .finished:
//                    // The publisher finished successfully
//                    break
//                }
//            }, receiveValue: { image in
//                self.imageView.image = image
//                if let image = image, let imageData = image.pngData() {
//                    ImageDownloader.images.setObject(imageData as NSData, forKey: url as NSString)
//                    print("cache Image")
//                }
//            })
//            .store(in: &cancellable)
//




    }
    
}







