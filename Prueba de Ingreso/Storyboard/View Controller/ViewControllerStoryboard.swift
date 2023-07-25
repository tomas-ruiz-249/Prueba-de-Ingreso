//
//  ViewControllerStoryboard.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 17/07/23.
//

import UIKit

class ViewControllerStoryboard: UIViewController {

    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private lazy var userViewModel = ViewModel()
    let searchController = UISearchController()
    
    override func loadView() {
        super.loadView()
        userViewModel.getUsers()
        userViewModel.updateView = { [weak self] in
            if let errorMessage = self?.userViewModel.errorMessage {
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                self?.present(alert, animated: false)
            } else {
                self?.tableView.reloadData()
            }
        }
        let nib = UINib(nibName: "UsersTableViewCellStoryboard", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UsersTableViewCellStoryboard")
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.backgroundColor = .primary
        //searchBar.searchTextField.leftView?.tintColor = .systemGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewControllerStoryboard: UITableViewDelegate, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell taped ")
    }
}
extension ViewControllerStoryboard: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userViewModel.filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCellStoryboard",
                                                 for: indexPath) as! UsersTableViewCellStoryboard
        cell.configure(with: self.userViewModel.filteredUsers[indexPath.row])
        
        cell.cellTapped = {
            let vc = PostsViewControllerStoryboard()
            self.present(vc, animated: true)
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if !text.isEmpty {
            userViewModel.filteredUsers = userViewModel.userArray.filter {
                let name = $0.name.lowercased()
                let text = text.lowercased()
                return name.contains(text)
            }
        }
        else{
            userViewModel.filteredUsers = userViewModel.userArray
        }
        
        print("filtered", userViewModel.filteredUsers.count, "total", userViewModel.userArray.count)
        
        self.tableView.reloadData()
         
    }
    
}
