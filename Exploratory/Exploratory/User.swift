//
//  User.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/15/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    
    var username: String
    var userID: String
    var userEmail: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey {
        case id
        case username
        case userID
        case userEmail
        case userProfileURL
    }
}
