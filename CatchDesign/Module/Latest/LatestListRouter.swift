//
//  ProductsRouter.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import UIKit

// Place holder for router type
protocol LatestListRouterType { }

protocol LatestListRouterDelegate{ }

final class LatestListRouter {
    private static var navigationController: UINavigationController?
    private weak var modalNavigationController: UINavigationController?
}

extension LatestListRouter: LatestListRouterType {
    static func entry(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        let interactor = LatestListInteractor(networkManager: NetworkManager())
        let presenter = LatestListPresenter(interactor: interactor, routerDelegate: self.init())
        interactor.interactorDelegate = presenter
        let viewController = LatestListViewController.instantiate(withPresenter: presenter)
        LatestListRouter.navigationController = factory(viewController)
        return LatestListRouter.navigationController!
    }
    static func entry() -> UIViewController {
        let interactor = LatestListInteractor(networkManager: NetworkManager())
        let presenter = LatestListPresenter(interactor: interactor, routerDelegate: self.init())
        interactor.interactorDelegate = presenter
        return LatestListViewController.instantiate(withPresenter: presenter)
        
    }
}
// Place holder for router delegate implementation
extension LatestListRouter: LatestListPresenterRouterDelegate{
    func pushDetailView(withItem item: Item) {
        print("calling push detailz")
        let itemDescritonVc = ItemDescriptionRouter.entry(withItem: item)
        LatestListRouter.navigationController?.pushViewController(itemDescritonVc, animated: true)
    }
    
    
}
