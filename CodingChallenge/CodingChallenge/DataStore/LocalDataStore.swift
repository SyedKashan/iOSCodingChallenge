//
//  LocalDataStore.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

class LocalDataStore: DataStore {
	func fetch(query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
		completion(.failure(AppError.dataMissing))
	}
}
