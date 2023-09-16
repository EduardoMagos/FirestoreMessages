//
//  UserUseCase.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import Foundation

protocol UserUseCase {
	
	typealias UserCompletionHandler = (User?, Error?) -> Void
	typealias UsersCompletionHandler = ([User]?, Error?) -> Void
	typealias UsersUpdateCompletionHandler = (Bool, Error?) -> Void
	
	func login(email: String, password: String, completion: @escaping UserCompletionHandler)
	func register(user: User, completion: @escaping UserCompletionHandler)
	func list(completion: @escaping UsersCompletionHandler)
	func show(idUser: String, completion: @escaping UserCompletionHandler)
	func update(user: User, completion: @escaping UsersUpdateCompletionHandler)
}
