//
// 
// RecipeDetailsViewController.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//

//With the help of this resource, I was able to successfully implement this page. https://johncodeos.com/how-to-make-a-stretchy-header-in-ios-using-swift/

import UIKit
import Combine


public protocol RecipeDetailsNavigation: AnyObject {
    func navigateBackToRecipes()
    func navigateToThirdPage()
}

class RecipeDetailsViewController: UIViewController, UIScrollViewDelegate {

    public weak var delegate: RecipeDetailsNavigation?
    private var subscribers = Set<AnyCancellable>()

    var viewModel: RecipeDetailsViewModel!

    let label : UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.textColor = .green
        label.numberOfLines = 0
        label.backgroundColor = .blue
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView

    }()

    let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Good_Food_Display_-_NCI_Visuals_Online")
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let headerContainerView =  {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    init(viewModel:RecipeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        observeImageView()
        viewModel.loadImage()
        fillData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    deinit{
        self.delegate?.navigateBackToRecipes()
    }

    private func observeImageView() {
        viewModel.$image.receive(on: RunLoop.main)
            .sink { image in
                self.imageView.image = image
            }.store(in: &subscribers)
    }

    private func addScrollView() {
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func addLabelView() {
        self.scrollView.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 200).isActive = true
    }

    private func addHeaderView() {
        self.scrollView.addSubview(headerContainerView)
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        let headerContainerViewBottom = headerContainerView.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -10)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        headerContainerViewBottom.isActive = true
    }

    private func addImageView() {
        self.headerContainerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor, constant: 0).isActive = true
        imageViewTopConstraint.isActive = true
    }

    func fillData() {
        label.text = viewModel.recipe.summary
    }

    private func addSubviews() {
        addScrollView()
        addLabelView()
        addImageView()
        addHeaderView()
    }
}





