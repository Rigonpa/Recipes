//
//  RecipesDataManager.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class RecipesListDataManager {
    
    let remoteDataManager: RecipesRemoteDataManager
    let localDataManager: RecipesLocalDataManager
    init(remoteDataManager: RecipesRemoteDataManager, localDataManager: RecipesLocalDataManager) {
        self.remoteDataManager = remoteDataManager
        self.localDataManager = localDataManager
    }
}

extension RecipesListDataManager: RecipesDataManager {
    func loadRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        remoteDataManager.loadRecipes(completion: completion)
    }
}
