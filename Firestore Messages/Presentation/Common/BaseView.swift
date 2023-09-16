//
//  BaseView.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 13/09/23.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftMessages

class BaseView: UIViewController {
	
	let userID = UserDefaults.standard.string(forKey: "id_user") ?? ""
	
	enum AlertType {
		case success
		case failed
		case info
		case warning
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(true, animated: false)
		self.setupUserInterface()
		self.viewGetData()
		if Constants.letsDebugg {
			self.viewWillTest()
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(true, animated: false)
		self.setupUserInterface()
		self.viewGetData()
	}
	
	func setupUserInterface() {
		DispatchQueue.main.async {
			self.viewLabels()
			self.viewInputs()
			self.viewButtons()
			self.viewExtraSetup()
		}
	}
	
	func returnScreen() {
		self.navigationController?.popViewController(animated: true)
	}
	
	func viewGetData() {} // Función para configurar las pruebas de la vista
	func viewWillTest() {} // Función para configurar las pruebas de la vista
	func viewLabels() {} // Función para configurar las etiquetas de la vista
	func viewInputs() {} // Función para configurar las entradas de la vista
	func viewButtons() {} // Función para configurar los botones de la vista
	func viewExtraSetup() {} // Función para las configuraciones extra de la vista
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	@objc func showKeyboard(notification: Notification) {
		if let tecladoSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let ajuste = tecladoSize.height
			UIView.animate(withDuration: 0.3) {
				self.view.frame.origin.y = -ajuste
			}
		}
	}

	@objc func hideKeyboard(notification: Notification) {
		UIView.animate(withDuration: 0.3) {
			self.view.frame.origin.y = 0
		}
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	func showAlertConfirm(_ viewController: UIViewController, title: String, message: String, confirmActionHandler: @escaping () -> Void) {
			let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
			let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
			let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (action) in
				confirmActionHandler()
			}
			alertController.addAction(cancelAction)
			alertController.addAction(confirmAction)
			viewController.present(alertController, animated: true, completion: nil)
		}
	
	func showLoadingView(view: UIView? = nil) {}
	
	func hideLoadingView() {}
	
	func addValidationActions(_ textField: SkyFloatingLabelTextField, validateFunction: Selector) {
		textField.addTarget(self, action: validateFunction, for: .editingChanged)
		textField.addTarget(self, action: validateFunction, for: .editingDidEnd)
	}
	
	func showValidation(textFiled: SkyFloatingLabelTextField, message: String, isEmail: Bool = false, lenght: Int = 2) -> Bool {
		if textFiled.text!.isEmpty || textFiled.text!.count <= lenght {
			textFiled.errorMessage = message
			return false
		} else {
			textFiled.errorMessage = ""
			if isEmail && self.isValidEmail(email: textFiled.text!) {
				textFiled.errorMessage = ""
				return true
			} else if isEmail && !self.isValidEmail(email: textFiled.text!) {
				textFiled.errorMessage = message
				return false
			} else {
				textFiled.errorMessage = ""
				return true
			}
		}
	}
	
	func isValidEmail(email: String) -> Bool {
		let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
		let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
		return emailPredicate.evaluate(with: email)
	}
	
	func showPopupAlert(message: String, type: AlertType) {
		
		let popupView = MessageView.viewFromNib(layout: .messageView)
		popupView.configureDropShadow()
		popupView.bodyLabel?.isHidden = true
		popupView.button?.isHidden = true
		popupView.iconImageView?.isHidden = false
		popupView.iconLabel?.isHidden = true
		
		switch type {
			
		case .success:
			popupView.titleLabel?.toSuccessText(text: message)
			popupView.iconImageView?.image = UIImage(named: "icon_pop_success")
			popupView.backgroundColor = Colors.greeSuccessBackground
			
		case .failed:
			popupView.titleLabel?.toFailedText(text: message)
			popupView.iconImageView?.image = UIImage(named: "icon_pop_failed")
			popupView.backgroundColor = Colors.redFailedBackground
			
		default:
			popupView.titleLabel?.toSuccessText(text: message)
			popupView.iconImageView?.image = UIImage(named: "icon_pop_success")
			popupView.backgroundColor = Colors.greeSuccessBackground
		}
		
		var popupConfig = SwiftMessages.Config()
		popupConfig.presentationStyle = .top
		popupConfig.duration = .seconds(seconds: 4)
		
		SwiftMessages.show(config: popupConfig, view: popupView)
	}
	
	func closeView() {
		self.dismiss(animated: true, completion: nil)
	}
	
	func navigateToChat(room: Room) {
		let messagesStoryboard = UIStoryboard(name: "MessagesView", bundle: nil)
		if let messagesViewController = messagesStoryboard.instantiateViewController(withIdentifier: "MessagesView") as? MessagesView {
			messagesViewController.room = room
			self.present(messagesViewController, animated: true, completion: nil)
		}
	}

}

extension BaseView: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
}
