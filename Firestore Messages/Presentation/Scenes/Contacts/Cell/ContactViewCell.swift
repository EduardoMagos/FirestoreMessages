//
//  ContactViewCell.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 15/09/23.
//

import UIKit

protocol ContactViewCellDelegate: AnyObject {
	func didSelectUser(_ userCell: User)
	func didSelectRoom(_ roomCell: Room)
}

class ContactViewCell: UITableViewCell {
	
	@IBOutlet weak var viewCell: UIView!
	@IBOutlet weak var imgProfile: UIImageView!
	@IBOutlet weak var lblFullName: UILabel!
	@IBOutlet weak var lblEmail: UILabel!
	@IBOutlet weak var btnSubmit: UIButton!
	
	var userID: String?
	var user: User?
	var room: Room?
	weak var delegate: ContactViewCellDelegate?
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	func setupCell(user: User) {
		self.user = user
		let fullName = "\(user.name) \(user.lastName)"
		self.viewCell.roundOut(cornerRadius: 10.0)
		self.lblFullName.toTitleCell(text: fullName)
		self.lblEmail.toLabelCell(text: user.email)
		self.btnSubmit.toSentButton()
	}
	
	func setupCellRoom(room: Room, user: String) {
		self.room = room
		self.viewCell.roundOut(cornerRadius: 10.0)
		self.lblFullName.toTitleCell(text: user)
		self.lblEmail.isHidden = true
		self.btnSubmit.toDetailButton()
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
	@IBAction func makeRoomAction(_ sender: UIButton) {
		if let user = self.user {
			delegate?.didSelectUser(user)
		}
		
		if let room = self.room {
			delegate?.didSelectRoom(room)
		}
	}
}
