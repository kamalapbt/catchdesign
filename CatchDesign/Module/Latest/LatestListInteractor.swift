//
//  ProductsInteractor.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import Foundation

protocol LatestListInteractorType {
    var interactorDelegate: LatestListInteractorDelegate? { get set }

    func fetchLatestList()
}

protocol LatestListInteractorDelegate: class {
    func onLatestlistFetched(items: [Item]?, error: Error?)
}

final class LatestListInteractor {
    private let networkManger: NetworkManager
    weak var interactorDelegate: LatestListInteractorDelegate?
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManger = networkManager
    }
    
}

extension LatestListInteractor: LatestListInteractorType {
    func fetchLatestList() {        
        self.networkManger.fetchRequest(.latest()) { (data) in
            switch data {
            case .success(let data):
                do {
                    let entities = try JSONDecoder().decode([Item].self, from: data)
                    self.interactorDelegate?.onLatestlistFetched(items: entities, error: nil)
                } catch {
                    self.interactorDelegate?.onLatestlistFetched(items:nil, error: error)
                }
                
            case .failure(let error):
                self.interactorDelegate?.onLatestlistFetched(items:nil, error: error)
            }
        }
    }
}
