//
//  String.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 13/09/23.
//

import Foundation
import UIKit

extension String {
	
	func toUserDate() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.locale = Locale(identifier: "es_MX")
		if let dateToFormat = dateFormatter.date(from: self) {
			dateFormatter.timeZone = TimeZone.current
			dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
			return dateFormatter.string(from: dateToFormat)
		}
		return ""
	}
	
	func toFormatUser(date: Date) -> String {
		return formatDate(dateToFormat: date, format: "d MMM yyyy, h:mm a")
	}
	
	func formatDate(dateToFormat: Date, format: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.locale = Locale(identifier: "es_MX")
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: dateToFormat)
	}
	
	var onlyLetters: String {
		let okayChars : Set<Character> =
		Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
		return String(self.filter {okayChars.contains($0) })
	}
	
	var email: String {
			let okayChars : Set<Character> =
			Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789@._-")
			return String(self.filter {okayChars.contains($0) })
	}

}
