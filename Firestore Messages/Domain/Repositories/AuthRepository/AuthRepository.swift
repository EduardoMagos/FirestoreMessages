//
//  UserRepository.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import Foundation
import Firebase

protocol UserRepository {
	typealias UserCompletionHandler = (User?, Error?) -> Void
	func login(email: String, password: String, completion: @escaping UserCompletionHandler)
	func register(name: String, email: String, password: String, completion: @escaping UserCompletionHandler)
}
