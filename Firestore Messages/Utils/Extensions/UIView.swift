//
//  UIView.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 13/09/23.
//

import Foundation
import UIKit

enum ToolbarType: String {
	case next = "Siguiente"
	case done = "Aceptar"
	case ready = "Listo"
}

extension UIView {
	
	static var identifier: String {
		return String(describing: self)
	}
	
	var identifier: String {
		return String(self.classForCoder.description().split(separator: ".").last ?? "")
	}
	
	static func nib() -> UINib {
		return UINib(nibName: self.identifier, bundle: nil)
	}
	
	func roundOut(cornerRadius: CGFloat = 25.0) {
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = true
	}
	
	func doneNextKeyboardToolBar(buttonType: ToolbarType, selectorFunction: Selector) -> UIToolbar {
		
		let toolBar = UIToolbar(
			frame: CGRect(
				origin: .zero,
				size: .init(
					width: self.frame.size.width,
					height: 30
				)
			)
		)
		
		let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let nextButton = UIBarButtonItem(
			title: buttonType.rawValue,
			style: .done,
			target: self,
			action: selectorFunction
		)
		toolBar.setItems([flexSpace, nextButton], animated: false)
		toolBar.barTintColor = Colors.firebaseBlue!
		toolBar.tintColor = .white
		toolBar.sizeToFit()
		
		return toolBar
	}
	
	func prepareForLayout() {
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	@discardableResult
	func fillSuperview(insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
		guard let superview = superview else { return [] }
		
		self.prepareForLayout()
		
		return [
			topAnchor.addConstraint(with: superview.topAnchor, constant: insets.top),
			leadingAnchor.addConstraint(with: superview.leadingAnchor, constant: insets.left),
			bottomAnchor.addConstraint(with: superview.bottomAnchor, constant: -insets.bottom),
			trailingAnchor.addConstraint(with: superview.trailingAnchor, constant: -insets.right),
		]
	}
	
}

extension NSLayoutYAxisAnchor {
	@discardableResult
	func addConstraint(
		with otherAnchor: NSLayoutYAxisAnchor,
		relation: NSLayoutConstraint.Relation = .equal,
		constant: CGFloat = 0) -> NSLayoutConstraint {
		
		var constraint: NSLayoutConstraint!
		switch relation {
		case .equal:
			constraint = self.constraint(equalTo: otherAnchor, constant: constant)
		case .greaterThanOrEqual:
			constraint = self.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
		case .lessThanOrEqual:
			constraint = self.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
		@unknown default:
			fatalError("\(relation) has not been implemented")
		}
		
		constraint.isActive = true
		return constraint
	}
}

extension NSLayoutXAxisAnchor {
	@discardableResult
	func addConstraint(
		with otherAnchor: NSLayoutXAxisAnchor,
		relation: NSLayoutConstraint.Relation = .equal,
		constant: CGFloat = 0) -> NSLayoutConstraint {
		
		var constraint: NSLayoutConstraint!
		switch relation {
		case .equal:
			constraint = self.constraint(equalTo: otherAnchor, constant: constant)
		case .greaterThanOrEqual:
			constraint = self.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
		case .lessThanOrEqual:
			constraint = self.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
		@unknown default:
			fatalError("\(relation) has not been implemented")
		}
		
		constraint.isActive = true
		return constraint
	}
}
