//
//  TableViewCell.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 29/06/23.
//

import UIKit

class TableViewCellViewModel {
    var user: User?
    static var userId: Int?
}

class TableViewCell: UITableViewCell {
    static let cellID = "cell"
    var viewModel = TableViewCellViewModel()
    var cellTapped: ((User) -> Void)?
    //MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var biggestStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var separatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 230
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var emailStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 4
        stackview.axis = .horizontal
        return stackview
    }()
    
    private lazy var phoneStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 4
        stackview.axis = .horizontal
        return stackview
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var phoneImgView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private lazy var emailImgView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private lazy var postsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Ver Publicaciones...", for: .normal)
        button.layer.cornerRadius = 7
        return button
    }()
    
    private lazy var emptyLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .systemBlue
        return label
    }()
    
    
    func configure(with item: User){
        self.viewModel.user = item
        containerView.backgroundColor = .clear
        
        nameLabel.text = item.name
        nameLabel.textColor = .primary
        phoneLabel.text = item.phone
        emailLabel.text = item.email
        
        phoneImgView.image = .init(systemName: "phone.fill")
        phoneImgView.tintColor = .primary
        emailImgView.image = .init(systemName: "mail.fill")
        emailImgView.tintColor = .primary
        
        postsButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(biggestStackView)
        
        biggestStackView.addArrangedSubview(contentStackView)
        biggestStackView.addArrangedSubview(separatingStackView)
        
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(phoneStackView)
        contentStackView.addArrangedSubview(emailStackView)
        
        phoneStackView.addArrangedSubview(phoneImgView)
        phoneStackView.addArrangedSubview(phoneLabel)
        
        emailStackView.addArrangedSubview(emailImgView)
        emailStackView.addArrangedSubview(emailLabel)
        
        separatingStackView.addArrangedSubview(emptyLabel)
        separatingStackView.addArrangedSubview(postsButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            containerView.leadingAnchor.constraint( equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            biggestStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            biggestStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            biggestStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 8),
            biggestStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            contentStackView.topAnchor.constraint(equalTo: biggestStackView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: biggestStackView.leadingAnchor)
            
        ])
    }
    
    @objc func didTapButton(){
        if let user = self.viewModel.user {
            self.cellTapped?(user)
            TableViewCellViewModel.userId = user.id
            print(TableViewCellViewModel.userId!)
        }
    }
}


