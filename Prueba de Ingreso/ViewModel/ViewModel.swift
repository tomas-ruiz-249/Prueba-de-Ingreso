//
//  Model.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 29/06/23.
//

import Foundation

class ViewModel{
    var updateView: (() -> Void)?
    var userArray: [User] = [] {
        didSet {
            self.filteredUsers = self.userArray
        }
    }
    var postArray = [Post]()
    var filteredUsers = [User]()
    var errorMessage: String?
    let networking = Networking()
    
    
    func getUsers() {
        networking.request(path: Networking.urlUser) { [weak self] (result: Result<[User], Error>) in
            switch result {
            case .success(let response):
                self?.userArray = response
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
            self?.updateView?()
        }
    }
    
    func getPosts() {
        networking.request(path: Networking.urlAllPosts) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let response):
                self?.postArray = response
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
            self?.updateView?()
        }
    }
    
    func getPostsFromUser() {
        networking.request(path: Networking.urlSpecificPost) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let response):
                self?.postArray = response
                print(Networking.urlSpecificPost)
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
            self?.updateView?()
        }
    }
}

