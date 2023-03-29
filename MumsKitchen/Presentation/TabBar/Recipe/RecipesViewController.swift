//
// 
// HomeViewController.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import UIKit
import Combine


enum Section {
    case main
}

extension Notification.Name {
    static let newEvent = Notification.Name("new_event")
}

protocol RecipesNavigation: AnyObject {
    func navigateToNextPage()
}

class RecipesViewController: UIViewController  {

    //typealias DataSource = UICollectionViewDiffableDataSource<Section, RecipePresentation>
    //typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RecipePresentation>
   // private var recipes: [Recipe] = []
    private var subscribers = Set<AnyCancellable>()
    private var viewModel: RecipesViewModel
    public var delegate: RecipesNavigation?
//    public var

    private lazy var recipesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.minimumInteritemSpacing = 0 // between cell in the same row
        //layout.minimumLineSpacing = 40 // between rows
        //layout.sectionInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50) // thw whole collection view
        /*
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 100, left: 50, bottom: 50, right: 50)
         }
         */
        //
        //layout.itemSize = CGSize(width: 300, height: 300) // cell width and height
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RecipesCollectionViewCell.self, forCellWithReuseIdentifier: RecipesCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    init(viewModel: RecipesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"
        view.backgroundColor = .white
        recipesCollectionView.backgroundColor = .white
        addSubViews()
        observeLoading()
        bindToRecipesDataSource()
        viewModel.getRandomRecipes()
    }

    struct Event {
        let title: String
        let scheduledOn: Date
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
    }
    
    func addSubViews() {
        recipesCollectionView.delegate = self
        self.view.addSubview(recipesCollectionView)

        NSLayoutConstraint.activate([
            recipesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recipesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            recipesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recipesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])

        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func bindToRecipesDataSource() {
        viewModel.$recipes.receive(on: RunLoop.main).sink { [unowned self] recipes in
          print(recipes, "<-- Recipes")
          print(viewModel.recipes, "<-- viewModel.Recipes")
            self.recipesCollectionView.delegate = self
            self.recipesCollectionView.dataSource = self
            self.recipesCollectionView.reloadData()
        }.store(in: &subscribers)

    }

    func observeLoading() {
        //viewModel.$isLoading: Published<Bool>.Publisher
        viewModel.$isLoading.receive(on: RunLoop.main).sink { isloading in
            switch isloading {
            case true:
                self.activityIndicator.startAnimating()
            case false:
                self.activityIndicator.stopAnimating()
            }
        }.store(in: &subscribers)
    }

}

extension RecipesViewController: UICollectionViewDelegateFlowLayout {


//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        CGSize(width: recipesCollectionView.bounds.width, height: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        CGSize(width: recipesCollectionView.bounds.width, height: 0)
//    }


//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//                return UIEdgeInsets(top: 50, left: 50, bottom: 0, right: 100)
//            }
//// In this example, sectionInsets is an instance of UIEdgeInsets that specifies the top, left, bottom, and right padding for the section.
    ///

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//            if indexPath.row == 2 {
//                return CGSize(width: view.frame.width/2 - 20, height: 500)
            return CGSize(width: view.frame.width/2 - 30, height: 200)
        }


//
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
            //scrollDirection: horizontal → this value represents the minimum spacing between successive columns.
            //scrollDirection: vertical → this value represents the minimum spacing between successive rows
            //layout.minimumInteritemSpacing = 0 // between cell in the same row    //layout.minimumLineSpacing = 40 // between rows

            // but since cell at index 0 has larger height and it follows the line spacing exactly 20 but other cells in this row has lower height in this line thus not follows 20 spacing their line spacing value is greater than 20.0 that’s why they name it as minimumLineSpacing (means minimum it follows this distance but this is not a guarantee). This is limitation of UICollectionViewFlowLayout
        }

//    width_of_the_screen = 376
//    width_of_each_cell = 100
//    no_of_cell_can_be_shown_in_this_width = (376/100) 3.76 (3)
//    total_space_taking_by_three_cell = 300
//    remaing_spacing = 76
//    minimumInteritemSpacing = 76 / 2 = 38


   // As shown in Figure 8 since scroll direction is vertical , the minimumInteritemSpacing will be the space between items in the same row. As you can the spacing bwteen items in row is 38 which is higher than we define that’s why it is called minimum. Question is how it calculates , I am not taking some point into account to make it simple
// lma ma ykon fare8 m3e al spacve between iitems in the same row
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 60
//    }

}

extension RecipesViewController: UICollectionViewDelegate, UICollectionViewDataSource {


//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 4
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.recipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipesCollectionViewCell.identifier, for: indexPath) as! RecipesCollectionViewCell
        myCell.recipe = self.viewModel.recipes[indexPath.row]
        return myCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.navigateToNextPage()
        print("User tapped on item \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipesCollectionViewCell.identifier, for: indexPath) as! RecipesCollectionViewCell
            // Animate the label in the cell
            myCell.animateLabel()
        }



}