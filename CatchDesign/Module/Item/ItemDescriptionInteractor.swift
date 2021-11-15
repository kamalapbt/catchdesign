//
//  ProductsInteractor.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import Foundation

protocol ItemDescriptionInteractorType {
    var interactorDelegate: ItemDescriptionInteractorDelegate? { get set }
}

protocol ItemDescriptionInteractorDelegate: class {
}

final class ItemDescriptionInteractor {
    private let networkManger: NetworkManager
    weak var interactorDelegate: ItemDescriptionInteractorDelegate?
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManger = networkManager
    }
    
}

extension ItemDescriptionInteractor: ItemDescriptionInteractorType {
}
