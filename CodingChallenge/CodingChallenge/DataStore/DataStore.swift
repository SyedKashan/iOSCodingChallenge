//
//  DataStore.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol DataStore {
	func fetch(query: String, fetchLimit: Int, completion: @escaping (Result<[Book], Error>) -> Void)
}

enum DataStoreError: String, Error {
	case noData, noInternet
}
