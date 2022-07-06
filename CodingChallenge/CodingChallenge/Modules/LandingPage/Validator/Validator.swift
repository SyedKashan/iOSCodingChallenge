//
//  Validator.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

enum ValidationError: Error {
	case empty
	case minLength
	
	var title: String {
		return LocalizableConstants.validationError.localized
	}
	
	var message: String {
		switch self {
			case .empty:
				return LocalizableConstants.emptyString.localized
			case .minLength:
				return LocalizableConstants.minLength.localized
		}
	}
}

class Validator {
	func validate(_ input: String?) -> Result<String, ValidationError> {
		guard
			let input = input,
			!input.isEmpty
		else { return .failure(.empty)}
		
		guard input.count >= 3 else {
			return .failure(.minLength)
		}
		return .success(input)
	}
}
