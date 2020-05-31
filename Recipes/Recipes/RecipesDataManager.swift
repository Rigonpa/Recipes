//
//  RecipesDataManager.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol RecipesDataManager {
    func loadRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void)
}
