//
//  UIButton.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 13/09/23.
//

import Foundation
import UIKit

extension UIButton {
	
	func toPrimaryButton(text: String) {
		self.layer.cornerRadius = 25
		self.clipsToBounds = true
		self.backgroundColor = Colors.firebaseBlue
		self.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16.0)
		self.tintColor = .white
		self.setTitle(text, for: .normal)
	}
	
	func toSecundaryButton(text: String) {
		self.layer.cornerRadius = 25
		self.clipsToBounds = true
		self.backgroundColor = UIColor(named: "gray_medium")
		self.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16.0)
		self.tintColor = .black
		self.setTitle(text, for: .normal)
	}
	
	func toLinkButton(text: String) {
		self.backgroundColor = .clear
		self.setTitle(text, for: .normal)
		self.tintColor = Colors.firebaseBlue
		self.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 16.0)!
		self.clipsToBounds = true
	}
	
	func toCircleButton(image: String) {
		self.setImage(UIImage(named: image), for: .normal)
		self.clipsToBounds = true
		self.backgroundColor = .clear
	}
	
	func toCloseButton() {
		self.setImage(UIImage(named: "icon_close"), for: .normal)
		self.clipsToBounds = true
		self.backgroundColor = .clear
	}
	
	func toLogoutButton() {
		self.setImage(UIImage(named: "icon_logout"), for: .normal)
		self.clipsToBounds = true
		self.backgroundColor = .clear
	}
	
	func toDetailButton() {
		self.setImage(UIImage(named: "icon_right_simple"), for: .normal)
		self.clipsToBounds = true
		self.backgroundColor = .clear
	}
	
	func toSentButton() {
		self.setImage(UIImage(named: "icon_sent"), for: .normal)
		self.clipsToBounds = true
		self.backgroundColor = .clear
	}
	
}
