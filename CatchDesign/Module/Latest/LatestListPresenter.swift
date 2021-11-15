//
//  ProductsPresenter.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import Foundation

protocol LatestListPresenterType {
    func onViewDidLoad(withView view: LatestListViewController)
    func getLatestList()
    func showDetail(forItem item: Item)
}

// Place holder for router delegate
protocol LatestListPresenterRouterDelegate: class {
    func pushDetailView(withItem item: Item)
}

extension LatestListPresenter: LatestListPresenterType {
    
    func onViewDidLoad(withView view: LatestListViewController) {
        self.view = view
    }
    
    func getLatestList() {
        self.interactor.fetchLatestList()
    }
    
    func showDetail(forItem item: Item) {
        self.routerDelegate?.pushDetailView(withItem: item)
    }
}

final class LatestListPresenter {
    private let interactor: LatestListInteractorType
    private var routerDelegate: LatestListPresenterRouterDelegate?
    
    weak var view: LatestListViewControllerType?
    
    init(interactor: LatestListInteractorType, routerDelegate: LatestListPresenterRouterDelegate) {
        self.interactor = interactor
        self.routerDelegate = routerDelegate
    }
}

extension LatestListPresenter: LatestListInteractorDelegate {
    
    func onLatestlistFetched(items: [Item]?, error: Error?) {
        guard let view = self.view else {
            assertionFailure("View should be present on LatestListPresenter")
            return
        }
        if(error != nil) {
            view.showAlert("Something went wrong, please try again later")
        }
        view.onRecievedData(items: items)
    }
}
