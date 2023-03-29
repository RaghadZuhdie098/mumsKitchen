//
//  ViewController.swift
//  MumsKitchen
//
//  Created by Raghad Ikhwizhieh on 19/09/2022.
//

import UIKit
import Foundation
public protocol LogInViewNavigation: AnyObject {
    func navigateToRecipesList()
}
class LogInViewController: UIViewController {

  //  weak var coordinator: LogInCoordinator? // When instantiate the LogInViewController We initilize
    public weak var delegate: LogInViewNavigation?


    lazy private var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("buttonText", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .white
        //button.setButtonFont(set: FontUtil.withSize(14, family: .primary, style: .bold))
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
        let bottomConstraint = actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([heightConstraints, leadingConstraints, trailingConstraints, bottomConstraint])
    }
    @objc func performAction(sender: UIButton!) {
     //   coordinator?.goToRecipesViewController()
        delegate?.navigateToRecipesList()
    }

 


//    @IBAction func LogInPressed(_ sender: Any) {
        // coordinator?.goToHomeTab() // will call goToHomeTab
//
//        DispatchQueue.global().async {
//            sleep(2)
//            DispatchQueue.main.async {
//                print("HELLO")
//            }
//        }
 //   }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupButton()
    }


}

