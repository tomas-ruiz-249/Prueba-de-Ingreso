//
//  PostsViewControllerStoryboard.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 24/07/23.
//

import UIKit

class PostsViewControllerStoryboard: UIViewController {

    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!
    
    private lazy var postsViewModel = ViewModel()
    
    override func loadView() {
        super.loadView()
        postsViewModel.getPosts()
        postsViewModel.updateView = { [weak self] in
            if let errorMessage = self?.postsViewModel.errorMessage {
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                self?.present(alert, animated: false)
            } else {
                self?.tableView.reloadData()
            }
        }
        let nib = UINib(nibName: "PostsTableViewCellStoryboard", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostsTableViewCellStoryboard")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}

extension PostsViewControllerStoryboard: UITableViewDelegate, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell taped")
    }
}

extension PostsViewControllerStoryboard: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsViewModel.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCellStoryboard",
                                                 for: indexPath) as! PostsTableViewCellStoryboard
        cell.configure(with: self.postsViewModel.postArray[indexPath.row])
        return cell
    }
    
    
}
