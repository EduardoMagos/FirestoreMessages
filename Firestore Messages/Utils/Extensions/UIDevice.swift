//
//  UIDevice.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 14/09/23.
//

import Foundation
import UIKit

extension UIDevice {
	
	var hasNotch: Bool {
		let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
		return bottom > 0
	}
	
}
