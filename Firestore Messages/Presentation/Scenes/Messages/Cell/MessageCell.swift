//
//  MessageCell.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 15/09/23.
//

import UIKit

class MessageCell: UITableViewCell {
	
	enum typeMessage {
	case sender
	case recipient
	}
	
	@IBOutlet weak var lblDate: UILabel!
	@IBOutlet weak var lblMessage: UILabel!
	@IBOutlet weak var viewMessage: UIView!
	@IBOutlet weak var imgGray: UIImageView!
	@IBOutlet weak var imgBlue: UIImageView!
	@IBOutlet weak var cnstrLeft: NSLayoutConstraint!
	@IBOutlet weak var cnstrRight: NSLayoutConstraint!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setupCell(type: typeMessage, message: Message) {
		self.viewMessage.roundOut(cornerRadius: 10.0)
		self.lblDate.toDetail(text: message.timestamp)
		self.lblMessage.toLabelCell(text: message.message)
		self.lblMessage.showAllContent()
		
		switch type {
		case .recipient:
			self.imgGray.isHidden = false
			self.imgBlue.isHidden = true
			self.cnstrLeft.constant = 0.0
			self.cnstrRight.constant = 40.0
			self.viewMessage.backgroundColor = Colors.firebaseGray
		case .sender:
			self.imgGray.isHidden = true
			self.imgBlue.isHidden = false
			self.cnstrLeft.constant = 40.0
			self.cnstrRight.constant = 0.0
			self.viewMessage.backgroundColor = Colors.firebaseBlueLight
		}
	}
    
}
