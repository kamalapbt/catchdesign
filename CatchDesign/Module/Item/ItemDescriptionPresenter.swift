//
//  ProductsPresenter.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import Foundation

protocol ItemDescriptionPresenterType {
    func onViewDidLoad(withView view: ItemDescriptionViewController)
    func showDetail(forItem item: Item)
}

// Place holder for router delegate
protocol ItemDescriptionPresenterRouterDelegate: class {
}

extension ItemDescriptionPresenter: ItemDescriptionPresenterType {
    
    func onViewDidLoad(withView view: ItemDescriptionViewController) {
        self.view = view
    }
    
    func showDetail(forItem item: Item) {
    
    }
    
}

final class ItemDescriptionPresenter {
    private let interactor: ItemDescriptionInteractorType
    private var routerDelegate: ItemDescriptionPresenterRouterDelegate?
    
    weak var view: ItemDescriptionViewControllerType?
    
    init(interactor: ItemDescriptionInteractorType, routerDelegate: ItemDescriptionPresenterRouterDelegate) {
        self.interactor = interactor
        self.routerDelegate = routerDelegate
    }
}

extension ItemDescriptionPresenter: ItemDescriptionInteractorDelegate {
}
