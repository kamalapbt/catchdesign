//
//  ViewController.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import UIKit

protocol ItemDescriptionViewControllerType: class {
    var presenter: ItemDescriptionPresenterType! { get }
    
    func showAlert(_ message: String)
}

class ItemDescriptionViewController: UIViewController {
    @IBOutlet weak var textViewContent: UITextView!
    var presenter: ItemDescriptionPresenterType!
    private var item: Item!
    
    
    
    internal static func instantiate(withPresenter presenter: ItemDescriptionPresenterType, item : Item) -> ItemDescriptionViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemDescriptionViewController") as! ItemDescriptionViewController
        vc.presenter = presenter
        vc.item = item
        vc.title = item.title
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.onViewDidLoad(withView: self)
        self.navigationController?.navigationBar.isHidden = false
        self.textViewContent.text = item.content
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension ItemDescriptionViewController: ItemDescriptionViewControllerType {
    
    
    func showAlert(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    
}


