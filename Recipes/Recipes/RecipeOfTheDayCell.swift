//
//  RecipeOfTheDayCell.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class RecipeOfTheDayCell: UITableViewCell {
    static var cellIdentifier: String = String(describing: RecipeOfTheDayCell.self)
    
    lazy var myView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var recipeOfDayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Marmitaco a la rupestre"
        label.tintColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var footerRecipeOfDayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recipe of the day"
        label.tintColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    var viewModel: RecipeOfTheDayCellViewModel? {
        didSet {
            setupUI()
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubview(myView)
        contentView.addSubview(recipeOfDayLabel)
        contentView.addSubview(footerRecipeOfDayLabel)

        NSLayoutConstraint.activate([
            myView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myView.heightAnchor.constraint(equalToConstant: 200),
            myView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recipeOfDayLabel.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            recipeOfDayLabel.centerYAnchor.constraint(equalTo: myView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            footerRecipeOfDayLabel.centerXAnchor.constraint(equalTo: recipeOfDayLabel.centerXAnchor),
            footerRecipeOfDayLabel.topAnchor.constraint(equalTo: recipeOfDayLabel.bottomAnchor, constant: 6)
        ])
    }
    
}
