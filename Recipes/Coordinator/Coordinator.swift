//
//  Coordinator.swift
//  Recipes
//
//  Created by Ricardo González Pacheco on 20/05/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class Coordinator {
    public var childCoordinators = [Coordinator]()
    
    func start(){
        preconditionFailure("Needs to extend this method in a subclass of Coordinator")
    }
    
    func finish() {
        preconditionFailure("Needs to extend this method in a subclass of Coordinator")
    }
    
    func addChildCoordinator(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(of: coordinator) else { return }
        childCoordinators.remove(at: index)
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter{ $0 is T == false }
    }
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
