//
//  ApiResponse.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

class ApiResponse<T: Codable>: Codable {
	
	var statusCode: Int?
	var message: String?
	var data: T?
	var updateAvailable: Int?
	var errors: [String]?
	
	enum CodingKeys: String, CodingKey {
		case statusCode = "status"
		case data = "data"
		case message = "message"
		case updateAvailable = "update_available"
		case errors = "error"
	}
	
	required public init(from decoder: Decoder) throws {
		
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? nil
		
		updateAvailable = try values.decodeIfPresent(Int.self, forKey: .updateAvailable) ?? nil
		
		if let data = try? values.decodeIfPresent(T.self, forKey: .data) {
			self.data = data
		} else {
			self.data = nil
		}
		
		if let message = try? values.decodeIfPresent(String.self, forKey: .message) {
			print(message)
			self.message = nil
		} else {
			self.message = nil
		}
		
		if let errors = try? values.decode([String].self, forKey: .errors) {
			self.errors = errors
		} else {
			self.errors = []
		}
	}
}

