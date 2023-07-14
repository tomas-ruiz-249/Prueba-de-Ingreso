//
//  ViewModel.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 29/06/23.
//

import Foundation

//MARK: - User
struct User: Codable, Equatable{
    
    static func == (lhs: User, rhs: User) -> Bool {
        let areEqual =
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.username == rhs.username &&
        lhs.email == rhs.email &&
        lhs.address == rhs.address &&
        lhs.phone == rhs.phone &&
        lhs.website == rhs.website &&
        lhs.company == rhs.company
        return areEqual
    }
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable, Equatable {
    
    static func == (lhs: Address, rhs: Address) -> Bool {
        let isEqual =
        lhs.street == rhs.street &&
        lhs.suite == rhs.suite &&
        lhs.city == rhs.city &&
        lhs.zipcode == rhs.zipcode &&
        lhs.geo == rhs.geo
        return isEqual
    }
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable, Equatable{
    let lat: String
    let lng: String
}

struct Company: Codable, Equatable{
    let name: String
    let catchPhrase: String
    let bs: String
}
//MARK: - Posts
struct Post: Codable, Equatable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

