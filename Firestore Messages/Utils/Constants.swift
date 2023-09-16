//
//  Constants.swift
//  Firestore Messages
//
//  Created by Luis Eduardo Magos Moreno on 13/09/23.
//

import Foundation

struct Constants {
	
	struct API {
		static let hostApi = "https://api.spacexdata.com/"
		static let contextApi = "v3/"
		static let routeApi = "launches/"
		static let launchPast = "\(hostApi)\(contextApi)\(routeApi)past"
	}
	
	static let letsDebugg = false
	
}
