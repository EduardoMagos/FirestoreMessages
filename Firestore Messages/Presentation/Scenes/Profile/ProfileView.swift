//
//  ProfileView.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileView: BaseView {
	
	//Outlet's
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var txtName: SkyFloatingLabelTextField!
	@IBOutlet weak var txtLastName: SkyFloatingLabelTextField!
	@IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
	@IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
	@IBOutlet weak var btnPassword: UIButton!
	@IBOutlet weak var btnSubmit: UIButton!
	@IBOutlet weak var btnClose: UIButton!
	
	// Variables
	let userUseCase = UserUseCaseImpl()
	var nameValid = false
	var lastNameValid = false
	var emailValid = false
	var passwordValid = false
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewLabels() {
		if userID != "" {
			self.lblTitle.toTitle(text: "Mi perfil")
		} else {
			self.lblTitle.toTitle(text: "Crear cuenta")
		}
	}
	
	override func viewInputs() {
		
		let toolBar = UIToolbar().doneNextKeyboardToolBar(
			buttonType: .next,
			selectorFunction: #selector(self.nextField)
		)
		
		self.txtName.toCustomInput(text: "Nombre(s)")
		self.txtName.customField(content: .name)
		self.txtName.assignToolBar(toolBar: toolBar)
		self.addValidationActions(self.txtName, validateFunction: #selector(self.validateName(_:)))
		
		self.txtLastName.toCustomInput(text: "Apellidos")
		self.txtLastName.customField(content: .name)
		self.txtLastName.assignToolBar(toolBar: toolBar)
		self.addValidationActions(self.txtLastName, validateFunction: #selector(self.validateLastName(_:)))
		
		self.txtEmail.toCustomInput(text: "Correo electrónico")
		self.txtEmail.customField(keyboardType: .emailAddress, content: .emailAddress)
		self.txtEmail.assignToolBar(toolBar: toolBar)
		self.addValidationActions(self.txtEmail, validateFunction: #selector(self.validateEmail(_:)))
		
		self.txtPassword.toCustomInput(text: "Contraseña")
		self.txtPassword.customField(content: .password, beSecure: true)
		self.txtPassword.assignToolBar(toolBar: toolBar)
		self.addValidationActions(self.txtPassword, validateFunction: #selector(self.validatePassword(_:)))
		
		if userID != "" {
			self.txtPassword.isHidden = true
			self.btnPassword.isHidden = true
		}
	}
	
	override func viewButtons() {
		if userID != "" {
			self.btnSubmit.toPrimaryButton(text: "Guardar")
			self.btnClose.toLogoutButton()
		} else {
			self.btnSubmit.toPrimaryButton(text: "Crear cuenta")
			self.btnClose.toCloseButton()
		}
		self.btnPassword.toCircleButton(image: "icon_show")
		self.btnSubmit.isEnabled = false
	}
	
	override func viewGetData() {
		if self.userID != "" {
			self.userUseCase.show(idUser: self.userID) { (user, error) in
				if let error = error {
					print("Error al recuperar las salas: \(error.localizedDescription)")
				} else if let user = user {
					self.btnSubmit.isEnabled = true
					self.txtName.text = user.name
					self.txtLastName.text = user.lastName
					self.txtEmail.text = user.email
					self.txtEmail.isEnabled = false
				}
			}
		}
	}
	
	@objc func nextField() {
		
		if self.txtName.isFirstResponder {
			
			self.txtName.resignFirstResponder()
			self.txtLastName.becomeFirstResponder()
			
		} else if self.txtLastName.isFirstResponder {
			
			self.txtLastName.resignFirstResponder()
			self.txtEmail.becomeFirstResponder()
			
		} else if self.txtEmail.isFirstResponder {
			
			self.txtEmail.resignFirstResponder()
			self.txtPassword.becomeFirstResponder()
			
		} else if self.txtPassword.isFirstResponder {
			
			self.txtPassword.resignFirstResponder()
			self.dismissKeyboard()
		}
		
	}
	
	func validateForm() {
		if userID != "" {
			self.btnSubmit.isEnabled = self.nameValid && self.lastNameValid
		} else {
			self.btnSubmit.isEnabled = self.nameValid && self.lastNameValid && self.emailValid && self.passwordValid
		}
		
	}
	
	func registerUser(userToRegister: User) {
		self.userUseCase.register(user: userToRegister) { [weak self] user, error in
			if let error = error {
				self?.showPopupAlert(message: "Ocurrio un error al registrar al usuario", type: .failed)
				print("Error al registrar usuario: \(error)")
			} else if let user = user {
				self?.btnSubmit.isUserInteractionEnabled = true
				self?.showPopupAlert(message: "Usuario registrado exitosamente", type: .success)
				self?.closeView()
			}
			self?.btnSubmit.isEnabled = true
		}
	}
	
	func updateUser(userToRegister: User) {
		self.userUseCase.update(user: userToRegister) { [weak self] success, error in
			if let error = error {
				self?.showPopupAlert(message: "Ocurrio un error al actualizar al usuario", type: .success)
				print("Error al registrar usuario: \(error)")
			} else if success == true {
				self?.showPopupAlert(message: "Usuario actualizado exitosamente", type: .success)
			} else {
				self?.showPopupAlert(message: "Ocurrio un error al actualizar al usuario", type: .success)
			}
			
			self?.btnSubmit.isEnabled = true
		}
	}
	
	@objc func validateName(_: Bool) {
		self.txtName.text = String(self.txtName.text!.onlyLetters.prefix(25))
		self.nameValid = self.showValidation(textFiled: self.txtName, message: "Ingresa un nombre(s) válido")
		self.validateForm()
	}
	
	@objc func validateLastName(_: Bool) {
		self.txtLastName.text = String(self.txtLastName.text!.onlyLetters.prefix(25))
		self.lastNameValid = self.showValidation(textFiled: self.txtLastName, message: "Ingresa unos apellidos válidos")
		self.validateForm()
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
	
	@IBAction func registerUserAction(_ sender: Any) {
		
		self.btnSubmit.isEnabled = false
		
		var user = User(
			id: "",
			name: self.txtName.text!,
			lastName: self.txtLastName.text!,
			email: self.txtEmail.text!,
			password: self.txtPassword.text!
		)
		
		if self.userID != "" {
			user.id = self.userID
			self.updateUser(userToRegister: user)
		} else {
			self.registerUser(userToRegister: user)
		}
		
	}
	
	@IBAction func showPassword(_ sender: Any) {
		let isSecurity = self.txtPassword.isSecureTextEntry
		self.txtPassword.isSecureTextEntry = !isSecurity
		let image = isSecurity ? "icon_hide" : "icon_show"
		self.btnPassword.setImage(UIImage(named: image), for: .normal)
	}
	
	@IBAction func closeViewAction(_ sender: Any) {
		
		if userID != "" {
			UserDefaults.standard.removeObject(forKey: "id_user")
		}

		self.closeView()
		
	}
}
