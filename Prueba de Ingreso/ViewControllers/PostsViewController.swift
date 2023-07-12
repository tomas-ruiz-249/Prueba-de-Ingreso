//
//  PostsViewController.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 6/07/23.
//

import UIKit

class PostsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 44
        tv.separatorStyle = .singleLine
        tv.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.cellID)
        return tv
    }()
    
    private lazy var postViewModel = ViewModel()
    
    override func loadView() {
        super.loadView()
        setup()
        postViewModel.getPostsFromUser()
        postViewModel.updateView = { [weak self] in
            if let errorMessage = self?.postViewModel.errorMessage {
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
    }
}

private extension PostsViewController{
    
    func setup(){
        self.navigationItem.title = "Publicaciones"
        self.navigationItem.titleView?.tintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.insetsLayoutMarginsFromSafeArea = false
        self.view.backgroundColor = .primary
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        self.tableView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension PostsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.cellID, for: indexPath) as! PostsTableViewCell
        cell.configure(with: self.postViewModel.postArray[indexPath.row])
        
        return cell
    }
    
    
}
