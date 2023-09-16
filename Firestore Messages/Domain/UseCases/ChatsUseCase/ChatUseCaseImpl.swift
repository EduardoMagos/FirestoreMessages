//
//  ChatUseCaseImpl.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 15/09/23.
//

import Foundation

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class ChatUseCaseImpl: ChatUseCase {
	
	let db = Firestore.firestore()
	
	func createRoom(senderUser: String, recipientUser: String, completion: @escaping RoomCompletionHandler) {
	
		var ref: DocumentReference? = nil
		
		ref = self.db.collection("rooms").addDocument(data: [
			"idSender": senderUser,
			"idRecipient": recipientUser
		]) { error in
			if let error = error {
				completion(nil, error)
			} else {
				let documentID = ref?.documentID
				let room = Room(id: documentID ?? "No ID", idSender: senderUser, idRecipient: recipientUser)
				completion(room, nil)
			}
		}
	}
	
	func listRooms(idUser: String, completion: @escaping RoomsCompletionHandler) {
		
		let db = Firestore.firestore()
		let roomsCollection = db.collection("rooms")
		var rooms: [Room] = []
		
		
		let query = db.collection("rooms").whereFilter(Filter.orFilter([
						Filter.whereField("idSender", isEqualTo: idUser),
						Filter.whereField("idRecipient", isEqualTo: idUser)
					]))
		
		query.getDocuments { (snapshot, error) in
			
			if let error = error {
				completion(nil, error)
				return
			}
			
			for document in snapshot!.documents {
				let documentData = document.data()
				let documentID = document.documentID

				if let idSender = documentData["idSender"] as? String,
				   let idRecipient = documentData["idRecipient"] as? String {
					
					
					if rooms.contains(where: { $0.id == documentID }) {
						// El objeto Room con el ID "123456" existe en el arreglo rooms
						print("El objeto Room con ID \(documentID) existe en el arreglo.")
					} else {
						// El objeto Room con el ID "123456" no existe en el arreglo rooms
						let room = Room(id: documentID, idSender: idSender, idRecipient: idRecipient)
						rooms.append(room)
					}
						
				}
			}
			

			completion(rooms, nil)
		}

	}
	
	func createMessage(message: Message, completion: @escaping MessageCompletionHandler) {
		var ref: DocumentReference? = nil
		
		ref = self.db.collection("messages").addDocument(data: [
			"idRoom": message.idRoom,
			"idUser": message.idUser,
			"message": message.message,
			"timestamp": FieldValue.serverTimestamp(),
		]) { error in
			if let error = error {
				completion(false, error)
			} else {
				completion(true, nil)
			}
		}
		
	}
	
	func listMessages(idRoom: String, completion: @escaping MessagesCompletionHandler) {
		
		let db = Firestore.firestore()
		let roomsCollection = db.collection("messages")
		
		let query = self.db.collection("messages")
			.whereField("idRoom", isEqualTo: idRoom) // Agrega cualquier otra condición que necesites
			.order(by: "timestamp", descending: false)
		
		query.getDocuments { (snapshot, error) in
			
			if let error = error {
				completion(nil, error)
				return
			}
			
			var messages: [Message] = []
			
			for document in snapshot!.documents {
				
				let documentID = document.documentID
				
				
				
				if let data = document.data() as? [String: Any],
				   let idRoom = data["idRoom"] as? String,
				   let idUser = data["idUser"] as? String,
				   let message = data["message"] as? String,
				   let timestamp = data["timestamp"] as? Timestamp {
					
					let date = timestamp.dateValue()
					let dateFormatter = DateFormatter()
					dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Elige un formato de fecha apropiado
					let formattedTimestamp = dateFormatter.string(from: date)
					
					let message = Message(
						id: documentID,
						idRoom: idRoom,
						idUser: idUser,
						message: message,
						timestamp: formattedTimestamp
					)
					messages.append(message)
				}
			}
			
			completion(messages, nil)
			
		}
	}
	
	func showCombineRoom(senderUser: String, recipientUser: String, completion: @escaping RoomSuccessCompletionHandler) {
		
		let db = Firestore.firestore()
		let query = db.collection("rooms").whereFilter(Filter.orFilter([
			Filter.andFilter([
				Filter.whereField("idSender", isEqualTo: senderUser),
				Filter.whereField("idRecipient", isEqualTo: recipientUser)
			]),
			Filter.andFilter([
				Filter.whereField("idSender", isEqualTo: recipientUser),
				Filter.whereField("idRecipient", isEqualTo: senderUser)
			])
		]))
		
		query.getDocuments { (snapshot, error) in
			
			if let error = error {
				completion(nil, false)
				return
			}
			
			if snapshot!.documents.count > 0 {
				for document in snapshot!.documents {
					let documentData = document.data()
					let documentID = document.documentID
					
					if let idSender = documentData["idSender"] as? String,
					   let idRecipient = documentData["idRecipient"] as? String {
						
						let room = Room(id: documentID, idSender: idSender, idRecipient: idRecipient)
						completion(room, true)
					}
				}
			} else {
				completion(nil, false)
			}
		}
		
	}
}
