//
//  UserRepositoryImp.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import Foundation
import Firebase

class UserRepositoryImpl: UserRepository {
	func login(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				completion(nil, error)
			} else if let user = authResult?.user {
				let registeredUser = User(id: user.uid, name: user.displayName!, lastName: user.displayName!, email: user.email!, password: "")
				completion(registeredUser, nil)
			}
		}
	}
	
	func register(name: String, email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
			if let error = error {
				completion(nil, error)
			} else if let user = authResult?.user {
				let registeredUser = User(id: user.uid, name: user.displayName!, lastName: user.displayName!, email: user.email!, password: "")
				completion(registeredUser, nil)
			}
		}
	}
}
