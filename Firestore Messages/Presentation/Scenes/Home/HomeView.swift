//
//  HomeTabBarController.swift
//  Vado-ios-daily
//
//  Created by Luis Eduardo Magos Moreno on 15/09/23.
//  Copyright © 2019 NCxT. All rights reserved.
//

import UIKit

class HomeView: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let chatViewController = UIStoryboard(name: "ChatsListView", bundle: nil).instantiateViewController(withIdentifier: "ChatsListView")
		let contactsViewController = UIStoryboard(name: "ContactsView", bundle: nil).instantiateViewController(withIdentifier: "ContactsView")
		let profileViewController = UIStoryboard(name: "ProfileView", bundle: nil).instantiateViewController(withIdentifier: "ProfileView")
		viewControllers = [chatViewController, contactsViewController, profileViewController]
		
		let textAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "Montserrat-Medium", size: 12)!,
			.foregroundColor: Colors.textBlack!
		]
		
		let selectedTextAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "Montserrat-Bold", size: 12)!,
			.foregroundColor: Colors.firebaseOrange!
		]

		if let items = tabBar.items {
			items[0].title = "Mensajes"
			items[0].image = UIImage(named: "icon_messages_gray")!.withRenderingMode(.alwaysOriginal)
			items[0].selectedImage = UIImage(named: "icon_messages")!.withRenderingMode(.alwaysOriginal)
			items[0].setTitleTextAttributes(textAttributes, for: .normal)
			items[0].setTitleTextAttributes(selectedTextAttributes, for: .selected)

			items[1].title = "Miembros"
			items[1].image = UIImage(named: "icon_users_gray")!.withRenderingMode(.alwaysOriginal)
			items[1].selectedImage = UIImage(named: "icon_users")!.withRenderingMode(.alwaysOriginal)
			items[1].setTitleTextAttributes(textAttributes, for: .normal)
			items[1].setTitleTextAttributes(selectedTextAttributes, for: .selected)

			items[2].title = "Perfil"
			items[2].image = UIImage(named: "icon_user_gray")!.withRenderingMode(.alwaysOriginal)
			items[2].selectedImage = UIImage(named: "icon_user")!.withRenderingMode(.alwaysOriginal)
			items[2].setTitleTextAttributes(textAttributes, for: .normal)
			items[2].setTitleTextAttributes(selectedTextAttributes, for: .selected)
		}
	
	}
	
}


