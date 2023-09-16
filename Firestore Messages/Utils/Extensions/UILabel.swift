//
//  Label.swift
//  Vado-ios-daily
//
//  Created by Luis Eduardo Magos Moreno on 13/09/23.
//  Copyright © 2023 Neology. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
	
	enum font: String {
		case montserrat = "Montserrat"
	}
	
	enum typeFont: String {
		case black = "Montserrat-Black"
		case bold = "Montserrat-Bold"
		case medium = "Montserrat-Medium"
		case regular = "Montserrat-Regular"
	}
	
	func setupLabel(type: typeFont, size: Double, text: String, color: UIColor = .black, underline: Bool = false) {
		self.font = UIFont(name: type.rawValue, size: size)!
		self.textColor = color
	}
	
	func toTitle(text: String) {
		self.font = UIFont(name: "Montserrat-Bold", size: 26.0)!
		self.textColor = Colors.textBlack
		self.text = text
	}
	
	func toTitleSmall(text: String) {
		self.font = UIFont(name: "Montserrat-Bold", size: 20.0)!
		self.textColor = Colors.textBlack
		self.text = text
	}
	
	func toDetails(text: String) {
		self.font = UIFont(name: "Montserrat-Regular", size: 14.0)!
		self.textColor = Colors.textBlack
		self.text = text
	}
	
	func toSuccessText(text: String) {
		self.font = UIFont(name: "Montserrat-Medium", size: 16.0)!
		self.textColor = Colors.greeSuccessText
		self.text = text
	}
	
	func toFailedText(text: String) {
		self.font = UIFont(name: "Montserrat-Medium", size: 16.0)!
		self.textColor = Colors.redFailedText
		self.text = text
	}
	
	func toTitleCell(text: String) {
		self.font = UIFont(name: "Montserrat-Bold", size: 16.0)!
		self.textColor = Colors.textBlack
		self.text = text
	}
	
	func toLabelCell(text: String) {
		self.font = UIFont(name: "Montserrat-Regular", size: 14.0)!
		self.textColor = Colors.textBlack
		self.text = text
	}
	
	func toDetail(text: String) {
		self.font = UIFont(name: "Montserrat-Light", size: 12.0)!
		self.textColor = UIColor(named: "text_dark")
		self.text = text
	}
	
	func showAllContent() {
		self.numberOfLines = 0
		self.adjustsFontSizeToFitWidth = false
	}
}
