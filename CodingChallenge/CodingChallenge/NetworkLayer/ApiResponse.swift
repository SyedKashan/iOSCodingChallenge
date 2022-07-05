//
//  ApiResponse.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

class ApiResponse<T: Codable>: Codable {

	var numFound: Int?
	var data: T?
	
	enum CodingKeys: String, CodingKey {
		case data = "docs"
		case numFound = "numFound"
	}
	
	required public init(from decoder: Decoder) throws {
		
		let values = try decoder.container(keyedBy: CodingKeys.self)
						
		if let data = try? values.decodeIfPresent(T.self, forKey: .data) {
			self.data = data
		} else {
			self.data = nil
		}
	}
}

