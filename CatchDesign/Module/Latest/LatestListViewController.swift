//
//  ViewController.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import UIKit

protocol LatestListViewControllerType: class {
    var presenter: LatestListPresenterType! { get }
    
    func onRecievedData(items: [Item]?)
    func showAlert(_ message: String)
}

class LatestListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: LatestListPresenterType!
    private var items: [Item] = []
    
    
    lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.clear
        refreshControl.transform = CGAffineTransform(scaleX: 2, y: 2);
        let refreshContents = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)
        refreshControl.addTarget(self, action: Selector(("handleRefresh:")), for: .valueChanged)
        guard let customRefreshView = refreshContents?[0] as? UIView else {
            return refreshControl
        }
        
        let refreshView = customRefreshView.viewWithTag(1230)
        
        for vw in (refreshView?.subviews)! {
            if let spinnerImage = vw as? UIImageView {
                let imagesArray = [
                    UIImage(named: "Loader 1")!,
                    UIImage(named: "Loader 2")!,
                    UIImage(named: "Loader 3")!,
                    UIImage(named: "Loader 4")!
                ]
                spinnerImage.animationImages = imagesArray
                spinnerImage.animationDuration = 0.7;
                spinnerImage.startAnimating()
            }
        }
        
        customRefreshView.frame = refreshControl.bounds
        refreshControl.addSubview(customRefreshView)
        return refreshControl
    }()
    
    internal static func instantiate(withPresenter presenter: LatestListPresenterType) -> LatestListViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LatestListViewController") as! LatestListViewController
        vc.presenter = presenter
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.onViewDidLoad(withView: self)
        self.tableView.refreshControl = refreshControl
    }
    
}

extension LatestListViewController: LatestListViewControllerType {
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        self.presenter.getLatestList()
    }
    
    func showAlert(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func onRecievedData(items: [Item]?) {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.items = items ?? []
            self?.tableView.reloadData()
        }
    }
}

extension LatestListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listItemCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) 
        listItemCell.textLabel?.text = self.items[indexPath.row].title
        listItemCell.detailTextLabel?.text = self.items[indexPath.row].subtitle
        
        return listItemCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.showDetail(forItem: self.items[indexPath.row])
    }
}

extension LatestListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return self.items.count > 0  ?  0 : self.view.bounds.height
    }
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
       let emptyViewNid = Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)
        guard let emptyView = emptyViewNid?[0] as? UIView else {
            return nil
        }
        
        return emptyView
    }
    
    
    
}

