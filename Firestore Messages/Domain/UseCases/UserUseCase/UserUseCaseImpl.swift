//
//  UserUseCaseImpl.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class UserUseCaseImpl: UserUseCase {
	
	typealias UserCompletionHandler = (User?, Error?) -> Void
	typealias UsersCompletionHandler = ([User]?, Error?) -> Void
	
	let db = Firestore.firestore()
	let userID = UserDefaults.standard.string(forKey: "id_user") ?? ""

	func login(email: String, password: String, completion: @escaping UserCompletionHandler) {
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				completion(nil, error)
			} else if let user = authResult?.user {
				let loggedInUser = User(id: user.uid, name: "", lastName: "", email: user.email!, password: "")
				completion(loggedInUser, nil)
			}
		}
	}

	func register(user: User, completion: @escaping UserCompletionHandler) {
		Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
			if let error = error {
				print(error.localizedDescription)
				completion(nil, error)
			} else if let userNew = authResult?.user {
				let registeredUser = User(id: userNew.uid, name: user.name, lastName: user.lastName, email: user.email, password: "")
				var ref: DocumentReference? = nil
				ref = self.db.collection("users").addDocument(data: [
					"uID": userNew.uid,
					"name": user.name,
					"last": user.lastName,
					"email": user.email
				]) { err in
					if let error = error {
						completion(nil, error)
					} else {
						completion(registeredUser, nil)
					}
				}
			}
		}
	}
	
	func list(completion: @escaping UsersCompletionHandler) {
		let db = Firestore.firestore()
		let usersCollection = db.collection("users")
		
		usersCollection.getDocuments { (snapshot, error) in
			if let error = error {
				completion(nil, error)
				return
			}
			
			var users: [User] = []
			
			for document in snapshot!.documents {
				if let data = document.data() as? [String: Any],
				   let id = data["uID"] as? String,
				   let name = data["name"] as? String,
				   let lastName = data["last"] as? String,
				   let email = data["email"] as? String {
					
					let user = User(id: id, name: name, lastName: lastName, email: email, password: "")
					
					if self.userID != user.id {
						users.append(user)
					}
					
				}
			}
			
			completion(users, nil)
		}
	}
	
	func show(idUser: String, completion: @escaping UserCompletionHandler) {
		
		let db = Firestore.firestore()
		let roomsCollection = db.collection("users")
		
		roomsCollection.whereField("uID", isEqualTo: idUser).getDocuments { (snapshot, error) in
			
			if let error = error {
				completion(nil, error)
				return
			}
			
			for document in snapshot!.documents {
				if let data = document.data() as? [String: Any],
				   let id = data["uID"] as? String,
				   let name = data["name"] as? String,
				   let lastName = data["last"] as? String,
				   let email = data["email"] as? String {
					
					let user = User(id: id, name: name, lastName: lastName, email: email, password: "")
					completion(user, nil)
				}
			}
		}
		
	}
	
	func update(user: User, completion: @escaping UsersUpdateCompletionHandler) {
		
		let idUserToUpdate = user.id

		let userNewData: [String: Any] = [
			"id": user.id,
			"name": user.name,
			"last": user.lastName,
			"email": user.email
		]

		self.db.collection("users")
			.whereField("id", isEqualTo: idUserToUpdate)
			.getDocuments { (querySnapshot, error) in
				if let error = error {
					print("Error al buscar el documento: \(error.localizedDescription)")
				} else {
					if let document = querySnapshot?.documents.first {
						let userRef = self.db.collection("users").document(document.documentID)
						
						userRef.setData(userNewData, merge: true) { error in
							if let error = error {
								print("Error al actualizar el documento: \(error)")
								completion(false, error)
							} else {
								completion(true, nil)
							}
						}
					} else {
						completion(false, nil)
					}
				}
			}


	}
}
