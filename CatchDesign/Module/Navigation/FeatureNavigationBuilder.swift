//
//  NavigationRouter.swift
//  Trademe
//
//  Created by Kamala Tennakoon on 6/10/21.
//

import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class FeatureNavigationBuilder {
    static func build(rootView view: UIViewController) -> UINavigationController {
       let navigationController = UINavigationController(rootViewController: view)
        if(view.isKind(of: LatestListViewController.self)) {
            view.navigationController?.navigationBar.isHidden = true
        }
        return navigationController
    }
}


