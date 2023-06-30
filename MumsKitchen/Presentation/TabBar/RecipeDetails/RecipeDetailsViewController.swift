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
    
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private let contentView = UIView()

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .green
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let summaryLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView

    }()

    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Good_Food_Display_-_NCI_Visuals_Online")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let headerContainerView =  {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private var IngrediantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(IngrediantCollectionViewCell.self, forCellWithReuseIdentifier: IngrediantCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor =  .blue.withAlphaComponent(0.1)
        return collectionView
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
        bindToRecipeInformation()
        observeLoading()
        viewModel.getRecipeInformation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
     //   navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      //  navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    private func bindToRecipeInformation() {
        viewModel.$recipe.receive(on: RunLoop.main).sink { [weak self] recipe in
            guard let self = self else { return }
            self.titleLabel.text = recipe?.title ?? ""
            self.IngrediantsCollectionView.reloadData()
            self.summaryLabel.text = recipe?.summary ?? ""
            guard let imageString = recipe?.image, let imageURL = URL(string: imageString) else {
                return
            }
            self.imageView.kf.setImage(with: imageURL)
        }.store(in: &subscribers)
    }
    
    private func observeLoading() {
        //viewModel.$isLoading: Published<Bool>.Publisher
        viewModel.$isLoading.receive(on: RunLoop.main).sink { isloading in
            switch isloading {
            case true:
                self.addLoadingView()
                self.activityIndicator.startAnimating()
            case false:
                self.addSubviews()
                self.activityIndicator.stopAnimating()
            }
        }.store(in: &subscribers)
    }
    
    deinit{
        self.delegate?.navigateBackToRecipes()
    }

    private func addScrollView() {
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }


   private func addContentView() {
        self.scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10).isActive = true
        contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 210).isActive = true
    }
    
    private let viewUnderTitle =  {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func addViewUnderTitle() {
        viewUnderTitle.heightAnchor.constraint(equalToConstant: 2).isActive = true
        viewUnderTitle.backgroundColor = .black
        contentView.addSubview(viewUnderTitle)
        viewUnderTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        viewUnderTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        viewUnderTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    }
    
    private func addLabelView() {
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        addViewUnderTitle()
        
    }
    
    private let viewUnderIngrediantCollectionView =  {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   private func addViewUnderIngrediantCollectionView() {
        viewUnderIngrediantCollectionView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        viewUnderIngrediantCollectionView.backgroundColor = .black
        contentView.addSubview(viewUnderIngrediantCollectionView)
        viewUnderIngrediantCollectionView.topAnchor.constraint(equalTo: IngrediantsCollectionView.bottomAnchor, constant: 10).isActive = true
        viewUnderIngrediantCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        viewUnderIngrediantCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    }
    
    private func addIngrediantCollectionView() {
        IngrediantsCollectionView.dataSource = self
        IngrediantsCollectionView.delegate = self
        contentView.addSubview(IngrediantsCollectionView)
        IngrediantsCollectionView.topAnchor.constraint(equalTo: viewUnderTitle.bottomAnchor, constant: 10).isActive = true
        IngrediantsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        IngrediantsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        IngrediantsCollectionView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        addViewUnderIngrediantCollectionView()
    }

    private func addHeaderView() {
        self.scrollView.addSubview(headerContainerView)
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        let headerContainerViewBottom = headerContainerView.bottomAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -10)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
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

    private func addSummaryLabel() {
        contentView.addSubview(summaryLabel)
        summaryLabel.topAnchor.constraint(equalTo: IngrediantsCollectionView.bottomAnchor, constant: 20).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func addLoadingView() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func fillData() {
      //  titleLabel.text = viewModel.recipe.title
    }

    private func addSubviews() {
        addScrollView()
        addContentView()
        addLabelView()
        addIngrediantCollectionView()
        addImageView()
        addHeaderView()
        addSummaryLabel()
    }
    
    
}





extension RecipeDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipe?.extendedIngredients?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: IngrediantCollectionViewCell.identifier, for: indexPath) as! IngrediantCollectionViewCell
        myCell.ingredient = viewModel.recipe?.extendedIngredients?[indexPath.row]
        return myCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //  let width = (collectionView.frame.width/3)  - 9// between 2 cell
        return CGSize(width: 120, height: 120)
    }
//    func collectionView(_ collectionView: UICollectionView, layout
//                        collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 18
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                   return 10 }
    //horizontal → this value represents the minimum spacing between successive columns.

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 20
        }
    // -> The minimum spacing to use between lines of items in the grid. The default value of this property is 10.0. For collection View having. This spacing is used to compute how many items can fit in a single line, but after the number of items is determined, the actual spacing may possibly be adjusted upward.

    //→ this value represents the minimum spacing between items in the same column

}

// https://ali-akhtar.medium.com/ui-part-2-uicollectionview-part-1-3858f4e3bcdd
