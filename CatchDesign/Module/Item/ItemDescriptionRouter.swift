//
//  ProductsRouter.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import UIKit

// Place holder for router type
protocol ItemDescriptionRouterType { }

protocol ItemDescriptionRouterDelegate{ }

final class ItemDescriptionRouter {
    private weak var navigationController: UINavigationController?
    private weak var modalNavigationController: UINavigationController?
}

extension ItemDescriptionRouter: ItemDescriptionRouterType {
    
    static func entry(withItem item: Item) -> UIViewController {
        let interactor = ItemDescriptionInteractor(networkManager: NetworkManager())
        let presenter = ItemDescriptionPresenter(interactor: interactor, routerDelegate: self.init())
        interactor.interactorDelegate = presenter
        return ItemDescriptionViewController.instantiate(withPresenter: presenter, item: item)
        
    }
}
// Place holder for router delegate implementation
extension ItemDescriptionRouter: ItemDescriptionPresenterRouterDelegate{
    
}
