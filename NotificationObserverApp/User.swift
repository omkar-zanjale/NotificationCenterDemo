//
//  User.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import Foundation


struct User: Decodable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
    var isFavorite: Bool?
}

struct Address: Decodable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
}


struct Company: Decodable {
    var name : String?
    var catchPhrase: String?
    var bs: String?
}
