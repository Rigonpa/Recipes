//
//  RecipesCoordinator.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class RecipesCoordinator: Coordinator {
    // I can not inicialize as RecipesDataManager because it is a protocol and has no initializer
    // However, as RecipesListDataManager extends from RecipesDataManager, I can use it to initilize dataManager
    let dataManager: RecipesListDataManager
    let presenter: UINavigationController
    init(dataManager: RecipesListDataManager, presenter: UINavigationController) {
        self.dataManager = dataManager
        self.presenter = presenter
    }
    
    override func start() {
        let recipesViewModel = RecipesViewModel(dataManager: dataManager)
        let recipesViewController = RecipesViewController(viewModel: recipesViewModel)
        recipesViewController.title = "Recipes"
        recipesViewModel.coordinatorDelegate = self
        recipesViewModel.viewDelegate = recipesViewController
        presenter.pushViewController(recipesViewController, animated: true)
    }
    
    override func finish() {}
}

extension RecipesCoordinator: RecipesCoordinatorDelegate {
    
}
