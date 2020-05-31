//
//  RecipesRemoteDataManagerImpl.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

enum RecipesRemoteDataManagerError: LocalizedError {
    case malformedUrl
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .malformedUrl:
            return NSLocalizedString("Malformed url", comment: "Malformed url")
        case .unknown:
            return NSLocalizedString("Unknown", comment: "Unknown")
        }
    }
}

final class RecipesRemoteDataManagerImpl: RecipesRemoteDataManager {
    lazy var session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        return session
    }()
    
    func loadRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search?q=chicken&app_id=bf965abd&app_key=4f9c5099ca66045e362bcba7eaeaf5db&from=0&to=10&calories=591-722&health=alcohol-free") else {
            completion(.failure(RecipesRemoteDataManagerError.malformedUrl)) // In result pattern, first value inside completion is .failure or .success, do not forget
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in // Next lines are in background color
            
            // 1st analyzing error variable
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            // 2nd analyzing response variable
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(RecipesRemoteDataManagerError.malformedUrl))
                }
                return
            }
            
            print("Response status: \(httpResponse.statusCode)")
            
            // 3rd analyzing data variable
            guard let data = data, let recipesResponse = try? JSONDecoder().decode(RecipesResponse.self, from: data) else { // JSONDecoder()()()().decode...
                DispatchQueue.main.async {
                    completion(.failure(RecipesRemoteDataManagerError.unknown))
                }
                return
            }
            
            let recipes = recipesResponse.hits.map { (hit) -> Recipe in // .map is like for but clear and easy to work with.
                
                let ingredients = hit.recipe.ingredients.map { (ingredientWeb) -> Ingredient in
                    let ingredient = Ingredient()
                    ingredient.name = ingredientWeb.text
                    return ingredient
                }
                
                let recipe = Recipe()
                recipe.name = hit.recipe.label
                recipe.ingredients = ingredients
                recipe.imageUrl = URL(string: hit.recipe.image)
                
                return recipe
            }
            DispatchQueue.main.async {
                completion(.success(recipes))
            }
        }
        dataTask.resume()
    }
}

struct RecipesResponse: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: RecipeWeb
}

struct RecipeWeb: Decodable {
    let label: String
    let image: String
    let ingredients: [IngredientWeb]
}

struct IngredientWeb: Decodable {
    let text: String
}
