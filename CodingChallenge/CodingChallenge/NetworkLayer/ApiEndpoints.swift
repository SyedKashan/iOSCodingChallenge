//
//  ApiEndpoints.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

enum ApiEndPoints {
	
	case search(searchText: String)
	
	var methodName: String {
		switch self {
		case .search(let searchText): return "search.json?q=\(searchText)"
		}
	}
}
