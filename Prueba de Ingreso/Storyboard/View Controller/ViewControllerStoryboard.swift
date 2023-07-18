//
//  ViewControllerStoryboard.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 17/07/23.
//

import UIKit

class ViewControllerStoryboard: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private lazy var userViewModel = ViewModel()
    
    private let numbers = ["first","second","third","fourth","fifth","sixth","seventh","eigth","ninth","tenth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}

extension ViewControllerStoryboard: UITableViewDelegate{
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
        cell.myLabel.text = self.numbers[indexPath.row]
        cell.myImage.backgroundColor = .systemRed
        return cell
    }
    
}
