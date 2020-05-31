//
//  RecipesViewController.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(RecipeOfTheDayCell.self, forCellReuseIdentifier: RecipeOfTheDayCell.cellIdentifier)
        tv.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.cellIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.tableFooterView = UIView()
        return tv
    }()
    
    let viewModel: RecipesViewModel
    init(viewModel: RecipesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        setupUI()
        viewModel.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // This required init is mandatory if using interface builder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: RecipeOfTheDayCell.cellIdentifier, for: indexPath) as? RecipeOfTheDayCell,
            let cellViewModel = viewModel.viewModel(indexPath: indexPath) as? RecipeOfTheDayCellViewModel {
            cell.viewModel = cellViewModel
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.cellIdentifier, for: indexPath) as? RecipeCell,
            let cellViewModel = viewModel.viewModel(indexPath: indexPath) as? RecipeCellViewModel {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension RecipesViewController: RecipesViewDelegate {
    func onShowingError() {
        let alert = UIAlertController(title: "Error", message: "Not possible to load recipes. Please try again later", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
    }
    
    func onSuccessLoadingRecipes() {
        tableView.reloadData()
    }
}
