//
//  ChatUseCase.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 15/09/23.
//

import Foundation

protocol ChatUseCase {
	
	typealias RoomCompletionHandler = (Room?, Error?) -> Void
	typealias RoomsCompletionHandler = ([Room]?, Error?) -> Void
	typealias MessageCompletionHandler = (Bool, Error?) -> Void
	typealias MessagesCompletionHandler = ([Message]?, Error?) -> Void
	typealias RoomSuccessCompletionHandler = (Room?, Bool) -> Void
	
	func createRoom(senderUser: String, recipientUser: String, completion: @escaping RoomCompletionHandler)
	func listRooms(idUser: String, completion: @escaping RoomsCompletionHandler)
	func createMessage(message: Message, completion: @escaping MessageCompletionHandler)
	func listMessages(idRoom: String, completion: @escaping MessagesCompletionHandler)
	func showCombineRoom(senderUser: String, recipientUser: String, completion: @escaping RoomSuccessCompletionHandler)
}
