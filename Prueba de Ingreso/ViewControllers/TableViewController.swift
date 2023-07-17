//
//  ViewController.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 29/06/23.
//

import UIKit
import Foundation

class TableViewController: UIViewController, UISearchResultsUpdating{
    
    //MARK: - UI
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 44
        tv.separatorStyle = .singleLine
        tv.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellID)
        return tv
    }()
    
    let searchController = UISearchController()
    
    private lazy var userViewModel = ViewModel()
    
    //MARK: - lifecycle
    
    override func loadView() {
        super.loadView()
        setup()
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
    }
}

private extension TableViewController{
    
    func setup(){
        self.navigationItem.title = "Prueba de Ingreso"
        self.navigationItem.titleView?.tintColor = .white
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.tintColor = .white
        self.navigationItem.searchController?.searchBar.barTintColor = .white
        let attributedPlaceholder = NSAttributedString(string: "Buscar Usuarios...",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.navigationItem.searchController?.searchBar.searchTextField.attributedPlaceholder = attributedPlaceholder
        self.navigationItem.searchController?.searchBar.searchTextField.leftView?.tintColor = .lightGray
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.insetsLayoutMarginsFromSafeArea = false
        self.view.backgroundColor = .primary
        
        self.tableView.dataSource = self
        
        self.view.addSubview(tableView)
        self.tableView.backgroundColor = .systemGray6
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension TableViewController: UITableViewDataSource, UISearchBarDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userViewModel.filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellID, for: indexPath) as! TableViewCell
        cell.configure(with: self.userViewModel.filteredUsers[indexPath.row])
        cell.cellTapped = { [weak self] user in
            let vc = PostsViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
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



