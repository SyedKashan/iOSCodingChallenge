//
//  NetworkConstants.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

struct NetworkConstants {
	
	static private let baseURL = "https://openlibrary.org/"

	static func getBaseUrl() -> String {
		return NetworkConstants.baseURL
	}
}
