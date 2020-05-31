//
//  RecipeCell.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    static var cellIdentifier: String = String(describing: RecipeCell.self)
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40
        view.alpha = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .black
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var ingredientsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .black
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    var viewModel: RecipeCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self

            profileImageView.alpha = 1
            profileImageView.image = viewModel.recipeImage
            recipeLabel.text = viewModel.recipe.name
            ingredientsLabel.text = viewModel.ingredientsText
            
            setupUI()
        }
    }
    
    private func setupUI() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(recipeLabel)
        contentView.addSubview(ingredientsLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            recipeLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            recipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            ingredientsLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            ingredientsLabel.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 16),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
}

extension RecipeCell: RecipeCellViewDelegate {
    func showImagesForFirstTime() {
        guard let viewModel = viewModel else { return }
        profileImageView.image = viewModel.recipeImage
        setNeedsLayout()
        
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut], animations: {[weak self] in
            guard let self = self else { return }
            self.profileImageView.alpha = 1
        }, completion: nil)
    }
}
