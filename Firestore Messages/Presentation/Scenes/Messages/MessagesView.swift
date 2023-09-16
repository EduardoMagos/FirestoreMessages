//
//  MessagesView.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 15/09/23.
//

import UIKit
import SkyFloatingLabelTextField

class MessagesView: BaseView {
	
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var tableMessages: UITableView!
	@IBOutlet weak var txtMessages: SkyFloatingLabelTextField!
	@IBOutlet weak var btnSent: UIButton!
	
	let userUseCase = UserUseCaseImpl()
	let chatUseCase = ChatUseCaseImpl()
	var room: Room?
	var messages: [Message] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewExtraSetup() {
		self.tableMessages.delegate = self
		self.tableMessages.dataSource = self
		self.tableMessages.separatorStyle = .none
		self.tableMessages.register(MessageCell.nib(), forCellReuseIdentifier: MessageCell.identifier)
	}
	
	override func viewLabels() {
		self.lblTitle.toTitleSmall(text: "")
	}
	
	override func viewInputs() {
		self.txtMessages.toCustomInput(text: "Ingresa tu mensaje")
		NotificationCenter.default.addObserver(self, selector: #selector(self.showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewGetData() {
		self.getUserData()
		self.getMessages()
	}
	
	private func getUserData() {
		
		let searchUser = (self.room!.idSender == self.userID) ? self.room!.idRecipient : self.room!.idSender
		
		self.userUseCase.show(idUser: searchUser) { (user, error) in
			if let error = error {
				print("Error al recuperar las salas: \(error.localizedDescription)")
			} else if let user = user {
				let fullName = "\(user.name) \(user.lastName)"
				self.lblTitle.toTitleSmall(text: fullName)
			}
		}
	}
	
	
	private func getMessages() {
		self.chatUseCase.listMessages(idRoom: self.room!.id) { (messages, error) in
			if let error = error {
				print("Error al recuperar los mensajes: \(error.localizedDescription)")
			} else if let messages = messages {
				if messages.count > 0 {
					self.messages = messages
					self.tableMessages.reloadData()
					let lastRowIndex = self.tableMessages.numberOfRows(inSection: 0) - 1
					let lastIndexPath = IndexPath(row: lastRowIndex, section: 0)
					self.tableMessages.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
				}
			}
		}
	}
	
	
	@IBAction func sentMessageAction(_ sender: Any) {
		
		self.btnSent.isEnabled = false
		let stringMessage = self.txtMessages.text ?? ""
		
		let message = Message(
			id: "",
			idRoom: self.room!.id,
			idUser: self.userID,
			message: stringMessage,
			timestamp: ""
		)
		
		self.chatUseCase.createMessage(message: message){ [weak self] success, error in
			if let error = error {
				self?.showPopupAlert(message: "Ocurrio un error al registrar mensaje", type: .failed)
				print("Error al registrar el mensaje: \(error)")
			} else if success {
				print("Mensaje enviado")
				self?.txtMessages.text = ""
				self?.getMessages()
			}
			self?.btnSent.isEnabled = true
		}
	}
	
}

extension MessagesView: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.messages.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let message = self.messages[indexPath.row]
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as? MessageCell else {
			return UITableViewCell()
		}
		
		
		if self.userID == message.idUser {
			cell.setupCell(type: .sender, message: message)
		} else {
			cell.setupCell(type: .recipient, message: message)
		}
		
		
		return cell
	}
}
