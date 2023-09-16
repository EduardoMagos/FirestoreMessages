//
//  ContactsView.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 15/09/23.
//

import UIKit

class ContactsView: BaseView {
	
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var tableContacts: UITableView!
	
	let userUseCase = UserUseCaseImpl()
	let chaUseCase = ChatUseCaseImpl()
	var users: [User] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
	override func viewLabels() {
		self.lblTitle.toTitle(text: "Miembros")
	}
	
	override func viewExtraSetup() {
		self.tableContacts.delegate = self
		self.tableContacts.dataSource = self
		self.tableContacts.separatorStyle = .none
		self.tableContacts.register(ContactViewCell.nib(), forCellReuseIdentifier: ContactViewCell.identifier)
	}
	
	override func viewGetData() {
		self.userUseCase.list { (users, error) in
			if let error = error {
				print("Error al recuperar usuarios: \(error.localizedDescription)")
			} else if let users = users {
				self.users = users
				self.tableContacts.reloadData()
			}
		}
	}
	
	func makeRoom(userCell: User) {
		
		self.chaUseCase.showCombineRoom(senderUser: self.userID, recipientUser: userCell.id) { [weak self] room, success in
			if success == true {
				self!.navigateToChat(room: room!)
			} else {
				self!.makeNewRoom(userNew: userCell)
			}
		}
		
	}
	
	private func makeNewRoom(userNew: User){
		let message = "¿Estás seguro de iniciar una sala con \(userNew.name)?"
		self.showAlertConfirm(self, title: "Iniciar sala", message: message) {
			self.chaUseCase.createRoom(senderUser: self.userID, recipientUser: userNew.id) { [weak self] room, error in
				if let error = error {
					self?.showPopupAlert(message: "Error al crear la sala", type: .failed)
					print("Error al crear la sala: \(error)")
				} else if let room = room {
					self!.navigateToChat(room: room)
				}
			}
			
		}
	}
}

extension ContactsView: UITableViewDataSource, UITableViewDelegate, ContactViewCellDelegate {
	
	func didSelectRoom(_ roomCell: Room) {
		print("Jakuna")
	}
	
	
	func didSelectUser(_ user: User) {
		self.makeRoom(userCell: user)
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let user = self.users[indexPath.row]
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactViewCell.identifier, for: indexPath) as? ContactViewCell else {
			return UITableViewCell()
		}
		
		cell.delegate = self
		cell.setupCell(user: user)
		
		return cell
	}
}
