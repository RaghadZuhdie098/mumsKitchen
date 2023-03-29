//
// 
// DefaultAlertViewController.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import UIKit

class DefaultAlertViewController: UIViewController {

    var title1: String
    var message: String
    var type: AlertType

    var actions: [AnyObject] = []

    enum AlertType {
        case success
        case failure
    }

    class Action {
        var title: String
        var closure: ((Action) -> ())?

        internal init(title: String, closure: ((DefaultAlertViewController.Action) -> ())? = nil) {
            self.title = title
            self.closure = closure
        }
    }

    init(title1: String, message: String, type: DefaultAlertViewController.AlertType) {
        self.title1 = title1
        self.message = message
        self.type = type
        super.init(nibName: nil, bundle: nil)
       

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    lazy private var titleLabel: UILabel = {
        var label = UILabel()
        label.text = title1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy private var messageLabel: UILabel = {
        var label = UILabel()
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let imageView: UIImageView = {
        let image = UIImage(named: "Group-2")
        let imageView  = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy private var stackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing   = 0
        stackView.addArrangedSubview(imageView)
        let view1 = UIView()
        view1.heightAnchor.constraint(equalToConstant: 32).isActive = true
        let view2 = UIView()
        view2.heightAnchor.constraint(equalToConstant: 16).isActive = true
        let view3 = UIView()
        view3.heightAnchor.constraint(equalToConstant: 65).isActive = true
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(view3)
        //stackView.addArrangedSubview(actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    lazy private var bottonView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupStackview()
        // setupButtonView()
        setupContentView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
    }

    @objc func performAction(_ sender: UIButton) {
        let action = actions[sender.tag] as! Action
        if (action.closure != nil) {
            action.closure?(action)
        }
        self.dismiss(animated: true, completion: nil)
        //addAction(type: .success)
    }

    func addAction(_ action: Action) {
        let actionButton: UIButton = {
            let button = UIButton()
            button.setTitle(action.title, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.textColor = .white
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            //button.setButtonFont(set: FontUtil.withSize(14, family: .primary, style: .bold))
            button.tag = actions.count
            button.contentHorizontalAlignment = .center
            button.backgroundColor = .systemYellow//Colors.pallet.eventBackgroundColor
            button.isUserInteractionEnabled = true
            button.addTarget(self, action: #selector(performAction), for: .touchUpInside)
            return button
        }()
        actions.append(action)
        stackView.addArrangedSubview(actionButton)
        let view1 = UIView()
        view1.heightAnchor.constraint(equalToConstant: 28).isActive = true
        stackView.addArrangedSubview(view1)

    }

    private func setupStackview() {
        self.contentView.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 28),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -28),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 42)
        ])
    }
//       self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -28),
    private func setupContentView() {
        self.view.addSubview(self.contentView)
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    private func prepare() {
//        switch type {
//        case .success:
//        titleLabel.font = FontUtil.withSize(12, family: .primary, style: .regular)
//        message.font = FontUtil.withSize(12, family: .primary, style: .regular)
//
//        case .failure:
//
//        }
    }
}
