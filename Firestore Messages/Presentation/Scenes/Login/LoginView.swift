//
//  LoginView.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import UIKit
import SkyFloatingLabelTextField

class LoginView: BaseView {
	
	//Outlet's
	@IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
	@IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
	@IBOutlet weak var btnSubmit: UIButton!
	@IBOutlet weak var btnRegister: UIButton!
	@IBOutlet weak var lblRegister: UILabel!
	
	let userUseCase = UserUseCaseImpl()
	var emailValid = false
	var passwordValid = false
	
	override func viewDidLoad() {
        super.viewDidLoad()
		UserDefaults.standard.removeObject(forKey: "id_user")
    }
	
	override func viewLabels() {
		self.lblRegister.toDetails(text: "¿No tienes una cuenta?")
	}
	
	override func viewInputs() {
		
		let toolBar = UIToolbar().doneNextKeyboardToolBar(
			buttonType: .next,
			selectorFunction: #selector(self.nextField)
		)

		self.txtEmail.toCustomInput(text: "Correo electrónico")
		self.txtEmail.customField(keyboardType: .emailAddress, content: .emailAddress)
		self.txtEmail.assignToolBar(toolBar: toolBar)
		self.addValidationActions(self.txtEmail, validateFunction: #selector(self.validateEmail(_:)))
		
		self.txtPassword.toCustomInput(text: "Contraseña")
		self.txtPassword.customField(content: .password, beSecure: true)
		self.txtPassword.assignToolBar(toolBar: toolBar)
		self.addValidationActions(self.txtPassword, validateFunction: #selector(self.validatePassword(_:)))
	}
	
	override func viewButtons() {
		self.btnSubmit.toPrimaryButton(text: "Iniciar sesión")
		self.btnSubmit.isEnabled = true
		self.btnRegister.toLinkButton(text: "Registrarte aquí")
		
	}
	
	override func viewWillTest() {
		self.txtEmail.text = "lalo@magos.com"
		self.txtPassword.text = "Lalofca123"
		self.btnSubmit.isEnabled = true
	}
	
	@objc func nextField() {
		
		if self.txtEmail.isFirstResponder {
			
			self.txtEmail.resignFirstResponder()
			self.txtPassword.becomeFirstResponder()
			
		} else if self.txtPassword.isFirstResponder {
			
			self.txtPassword.resignFirstResponder()
			self.dismissKeyboard()
		}
		
	}
	
	func validateForm() {
		self.btnSubmit.isEnabled = self.emailValid && self.passwordValid
	}
	
	func goToHome() {
		let tabBarController = HomeView()
		tabBarController.modalPresentationStyle = .fullScreen
		self.present(tabBarController, animated: true, completion: nil)
	}
	
	@objc func validateEmail(_: Bool) {
		self.txtEmail.text = String(self.txtEmail.text!.email.prefix(50))
		self.emailValid = self.showValidation(textFiled: self.txtEmail, message: "Ingresa un correo electrónico válido", isEmail: true)
		self.validateForm()
	}
	
	@objc func validatePassword(_: Bool) {
		self.txtPassword.text = String(self.txtPassword.text!.email.prefix(30))
		self.passwordValid = self.showValidation(textFiled: self.txtPassword, message: "Inngresa una contraseña válida", lenght: 6)
		self.validateForm()
	}
	
	@IBAction func loginAction(_ sender: UIButton) {
		
		self.btnSubmit.isEnabled = false
		let email = self.txtEmail.text!
		let password = self.txtPassword.text!
		
		self.userUseCase.login(email: email, password: password) { [weak self] user, error in
			if let error = error {
				self?.showPopupAlert(message: "Error al iniciar sesión", type: .failed)
				print("Error al registrar usuario: \(error)")
			} else if let user = user {
				UserDefaults.standard.set(user.id, forKey: "id_user")
				self?.goToHome()
			}
			self?.btnSubmit.isEnabled = true
		}
		
	}
	

	@IBAction func goToRegisterUser(_ sender: Any) {
		let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileView")
		present(viewController, animated: true, completion: nil)
	}
	
}


