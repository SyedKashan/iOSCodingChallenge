//
//  ApiResponse.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

class ApiResponse: Codable {
	var books: [Book]
	
	enum CodingKeys: String, CodingKey {
		case books = "docs"
	}
}

