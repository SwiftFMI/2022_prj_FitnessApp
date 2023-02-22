//
//  FriendModel.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 21.02.23.
//

import Foundation
import UIKit

struct FriendModel: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var image: UIImage
    let email: String
    let name: String

    init(id: String = UUID().uuidString, image: UIImage, email: String, name: String) {
        self.id = id
        self.image = image
        self.email = email
        self.name = name
    }

    init(image: UIImage, friendModel: FriendModel) {
        id = friendModel.id
        self.image = image
        email = friendModel.email
        name = friendModel.name
    }
}
