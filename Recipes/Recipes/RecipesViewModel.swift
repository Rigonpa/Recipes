//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol RecipesCoordinatorDelegate {
    
}

protocol RecipesViewDelegate {
    func onShowingError()
    func onSuccessLoadingRecipes()
}

class RecipesViewModel {
    
    var coordinatorDelegate: RecipesCoordinatorDelegate?
    var viewDelegate: RecipesViewDelegate?
    
    var cellViewModels: [CellViewModel] = []
    
    let dataManager: RecipesDataManager
    init(dataManager: RecipesDataManager) {
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {
        dataManager.loadRecipes {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.onShowingError()
            case .success(let recipes):
                self.cellViewModels = recipes.map { RecipeCellViewModel(recipe: $0)}
//                self.cellViewModels = recipes.map { (recipe) -> RecipeCellViewModel in
//                    let recipeCellViewModel = RecipeCellViewModel(recipe: recipe)
//                    return recipeCellViewModel
//                }
                self.cellViewModels.insert(RecipeOfTheDayCellViewModel(), at: 0)
                self.viewDelegate?.onSuccessLoadingRecipes()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return cellViewModels.count
    }
    
    func viewModel(indexPath: IndexPath) -> CellViewModel? {
        guard indexPath.row < cellViewModels.count else { fatalError() }
        return cellViewModels[indexPath.row]
    }
}
