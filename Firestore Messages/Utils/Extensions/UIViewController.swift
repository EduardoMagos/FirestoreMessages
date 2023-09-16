//
//  UIViewController.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import Foundation
import UIKit

private struct AssociatedKeys {
	static var navigationBarShowShadow = "UIViewController.navigationBarShowShadow"
	static var navigationBarVisible = "UIViewController.navigationBarVisible"
	static var navigationBarColor = "UIViewController.navigationBarColor"
}

extension UIViewController {
	
	private var navigationBarVisible: Bool {
		get { return (objc_getAssociatedObject(self, &AssociatedKeys.navigationBarVisible) as? NSNumber)?.boolValue ?? true }
		set { objc_setAssociatedObject(self, &AssociatedKeys.navigationBarVisible, NSNumber(value: newValue), .OBJC_ASSOCIATION_COPY) }
	}
	
	func setNavigationBarVisibility(isVisible: Bool) {
		navigationBarVisible = isVisible
		navigationController?.setNavigationBarHidden(!isVisible, animated: false)
	}
}
