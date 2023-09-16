//
//  SkyFloatingLabelTextField.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
	
	func toCustomInput(text: String) {
		self.font = UIFont(name: "Montserrat-Regular", size: 16.0)
		self.placeholder = text
		self.title = text
		self.lineHeight = 1.0
		self.selectedLineHeight = 2.0
		self.tintColor = Colors.firebaseOrange! // Color del title cuando hay algun texto
		self.textColor = Colors.textBlack! // Color del texto
		self.lineColor = Colors.textBlack! // Color de la linea cuando no está seleccionado
		self.selectedTitleColor = Colors.firebaseOrange! // Color de la sombra cuando seleccionas el elemento
		self.selectedLineColor = Colors.firebaseOrange! // Color de la linea cuando está seleccionado
	}
	
	func customField(
		correction: UITextAutocorrectionType = .no,
		keyboardType: UIKeyboardType = .asciiCapable,
		content: UITextContentType = .name,
		beSecure: Bool = false
	) {
		self.isSecureTextEntry = beSecure
		self.autocorrectionType = correction
		self.keyboardType = keyboardType
		self.textContentType = content
	}
	
	func assignToolBar(toolBar: UIToolbar) {
		self.inputAccessoryView = toolBar
	}
	
}

extension SkyFloatingLabelTextFieldWithIcon {
	
	func toCustomInputImage(text: String, imageName: String) {
		self.font = UIFont(name: "Montserrat-Regular", size: 16.0)
		self.placeholder = text
		//self.title = text
		self.lineHeight = 1.0
		self.selectedLineHeight = 2.0
		self.tintColor = Colors.firebaseOrange! // Color del title cuando hay algun texto
		self.textColor = Colors.textBlack! // Color del texto
		self.lineColor = Colors.textBlack! // Color de la linea cuando no está seleccionado
		self.selectedTitleColor = Colors.firebaseOrange! // Color de la sombra cuando seleccionas el elemento
		self.selectedLineColor = Colors.firebaseOrange! // Color de la linea cuando está seleccionado
		self.iconImage = UIImage(imageLiteralResourceName: imageName)
	}
	
}

