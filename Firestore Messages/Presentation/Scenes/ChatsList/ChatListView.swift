//
//  ChatListView.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 13/09/23.
//

import UIKit

class ChatListView: BaseView {
	
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var tableChats: UITableView!
	
	let chaUseCase = ChatUseCaseImpl()
	let userUseCase = UserUseCaseImpl()
	var rooms: [Room] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewLabels() {
		self.lblTitle.toTitle(text: "Mensajes")
	}
    
	override func viewExtraSetup() {
		self.tableChats.delegate = self
		self.tableChats.dataSource = self
		self.tableChats.separatorStyle = .none
		self.tableChats.register(ContactViewCell.nib(), forCellReuseIdentifier: ContactViewCell.identifier)
	}
	
	override func viewGetData() {
		self.getRooms()
		
	}
	
	private func getRooms() {
		self.chaUseCase.listRooms(idUser: self.userID) { (roomsResponse, error) in
			if let error = error {
				print("Error al recuperar las salas: \(error.localizedDescription)")
			} else if let roomsService = roomsResponse {
				self.rooms = roomsService
				self.tableChats.reloadData()
			}
		}
	}
	
	func showRoom(roomCell: Room) {
		self.navigateToChat(room: roomCell)
	}

}

extension ChatListView: UITableViewDataSource, UITableViewDelegate, ContactViewCellDelegate {
	
	func didSelectUser(_ userCell: User) {
		print("Hao")
	}
	
	func didSelectRoom(_ roomCell: Room) {
		self.showRoom(roomCell: roomCell)
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.rooms.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let room = self.rooms[indexPath.row]
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactViewCell.identifier, for: indexPath) as? ContactViewCell else {
			return UITableViewCell()
		}
		
		cell.delegate = self
		
		let searchUser = (room.idSender == self.userID) ? room.idRecipient : room.idSender
		var fullName = ""
		self.userUseCase.show(idUser: searchUser) { (user, error) in
			if let error = error {
				print("Error al recuperar las salas: \(error.localizedDescription)")
			} else if let user = user {
				fullName = "\(user.name) \(user.lastName)"
				cell.setupCellRoom(room: room, user: fullName)
			}
		}
		
		return cell
	}
}

