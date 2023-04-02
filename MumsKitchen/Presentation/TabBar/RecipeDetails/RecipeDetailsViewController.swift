//
// 
// RecipeDetailsViewController.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import UIKit

public protocol RecipeDetailsNavigation: AnyObject {
    func navigateBackToRecipes()
    func navigateToThirdPage()
}

class RecipeDetailsViewController: UIViewController {

    public weak var delegate: RecipeDetailsNavigation?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupButton()
    }

    deinit{
        self.delegate?.navigateBackToRecipes()
    }

    lazy private var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("buttonText", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .white
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .darkGray
        button.isUserInteractionEnabled = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        return button
    }()

    private func setupButton() {
        self.view.addSubview(actionButton)
        let heightConstraints = actionButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        let leadingConstraints = actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let trailingConstraints = actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let bottomConstraint = actionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor , constant: 0)
        NSLayoutConstraint.activate([heightConstraints, leadingConstraints, trailingConstraints, bottomConstraint])
    }
    @objc func performAction(sender: UIButton!) {
       // coordinator?.goToRecipesViewController()
        print("performAction")
        let controller = DefaultAlertViewController(mainTitle: "title", message: "message", alertType: .failure)
        controller.addAction(DefaultAlertViewController.Action(title: "actionTitle") {})
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
       present(controller, animated: true)

    }
}
