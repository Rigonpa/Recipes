//
//  RecipeCellViewModel.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

protocol RecipeCellViewDelegate {
    func showImagesForFirstTime()
}

class RecipeCellViewModel: CellViewModel {
    
    var viewDelegate: RecipeCellViewDelegate?
    
    var recipeImage: UIImage?
    var ingredientsText: String?
    
    let recipe: Recipe
    init(recipe: Recipe) {
        self.recipe = recipe
        
        ingredientsText = recipe.ingredients.reduce("", { (previous, ingredient) -> String in
            if previous == "" {
                return "\(ingredient.name)"
            }
            return "\(previous), \(ingredient.name)"
        })
        
        super.init()
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            guard let url = recipe.imageUrl, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.recipeImage = UIImage(data: imageData)
                self.viewDelegate?.showImagesForFirstTime()
            }
        }
    }
}
