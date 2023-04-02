//
// 
// DefaultAlert.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import UIKit



class DefaultAlertViewController: UIViewController {

    struct Constants {
        static let buttonHeight: CGFloat = 44
        static let viewCornerRadius: CGFloat = 18
        static let alphaValue: CGFloat = 0.8
    }



    class Action {
        var title: String
        var closure: (() -> (Void))?
        internal init(title: String, closure: (() -> (Void))? = nil) {
            self.title = title
            self.closure = closure
        }
    }

    private var message: String
    private var mainTitle: String
    private var alertType: AlertType
    private var actions: [Action] = []
    private var contentInsets: UIEdgeInsets

    init(mainTitle: String, message: String, contentInsets: UIEdgeInsets = UIEdgeInsets(top: 41, left: 28, bottom: 28, right: 28), alertType: DefaultAlertViewController.AlertType = .default) {
        self.mainTitle = mainTitle
        self.message = message
        self.contentInsets = contentInsets
        self.alertType = alertType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy private var titleLabel: UILabel = {
        var label = UILabel()
        label.text = mainTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy private var messageLabel: UILabel = {
        var label = UILabel()
        label.text = message
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var imageView: UIImageView = {
        let imageView  = UIImageView()
        if let imageName = self.alertType.imageName {
            imageView.image = UIImage(named: imageName)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy private var actionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()

    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.viewCornerRadius
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        setupStackview()
        setupContentView()
      //  addImageView()
        addTitleLabel()
        addMessageLabel()
        addActionView()
    }

    private func setupStackview() {
        self.contentView.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: contentInsets.left),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -contentInsets.right),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -contentInsets.bottom),
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: contentInsets.top)
        ])
    }

    private func setupContentView() {
        self.view.addSubview(self.contentView)
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    private func addImageView() {
        if let _ = self.alertType.imageName {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            NSLayoutConstraint.activate([
                self.imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
                self.imageView.topAnchor.constraint(equalTo: view.topAnchor)
            ])
            stackView.addArrangedSubview(view)
        }
    }

    private func addTitleLabel() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        stackView.addArrangedSubview(view)
    }

    private func addMessageLabel() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            self.messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.messageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            self.messageLabel.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        stackView.addArrangedSubview(view)
    }

    private func addActionView() {
        stackView.addArrangedSubview(actionStackView)
    }

    func addAction(_ action: Action) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .green
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        button.tag = actions.count
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .yellow
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        button.setTitle(action.title, for: .normal)
        actions.append(action)
        actionStackView.addArrangedSubview(button)
        actionStackView.isHidden = false
    }

    @objc func performAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.actions[sender.tag].closure?()
        }
    }

}

extension DefaultAlertViewController {

    enum AlertType {
        case success
        case failure
        case `default`

        var imageName: String? {
            switch self {
            case .success:
                return "CheckBoxDone"
            case .failure:
                return "crossWithCircleFrame"
            case .`default`:
                return nil

            }
        }
    }
}

