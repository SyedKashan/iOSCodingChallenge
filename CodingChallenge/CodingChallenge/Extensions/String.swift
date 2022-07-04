//
//  String.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

extension String {
	func getCleanedURL() -> URL? {
		guard self.isEmpty == false else {
			return nil
		}
		if let url = URL(string: self) {
			return url
		} else {
			if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let escapedURL = URL(string: urlEscapedString) {
				return escapedURL
			}
		}
		return nil
	}
}

extension String {
	var localized: String {
		NSLocalizedString(self, comment: "") // Local Localized String Service
	}
}
