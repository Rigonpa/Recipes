//
//  AppCoordinator.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    lazy var remoteDataManager: RecipesRemoteDataManager = {
        // I can not inicialize as RecipesRemoteDataManager because it is a protocol and has no initializer
        // However, as RecipesRemoteDataManagerImpl extends from RecipesRemoteDataManager, I can use it to initilize remoteDataManager
        let remoteDataManager = RecipesRemoteDataManagerImpl()
        return remoteDataManager
    }()
    
    lazy var localDataManager: RecipesLocalDataManager = {
        let localDataManager = RecipesLocalDataManagerImpl()
        return localDataManager
    }()
    
    lazy var dataManager: RecipesListDataManager = {
        let dataManager = RecipesListDataManager(remoteDataManager: remoteDataManager, localDataManager: localDataManager)
        return dataManager
    }()
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        let recipesNavigationController = UINavigationController()
        let recipesCoordinator = RecipesCoordinator(dataManager: dataManager, presenter: recipesNavigationController)
        recipesCoordinator.start()
        
        window.rootViewController = recipesNavigationController
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
}
