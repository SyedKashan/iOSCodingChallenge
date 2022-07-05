//
//  RemoteDataStore.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

class RemoteDataStore: DataStore {
	func fetch(query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
		let apiRequest = ApiManager<[Book]>(successHandler: { bookData in
			guard bookData.count > 0 else {
				completion(.failure(AppError.dataMissing))
				return
			}
			let books = bookData.count > 10 ? Array(bookData.prefix(10).self) : bookData
			completion(.success(books))
		}, nullDataSuccessHandler: { (httpStatusCode: HttpStatusCode) in
			completion(.failure(AppError.dataMissing))
		}, errorHandler: { (httpStatusCode, errorMessage) in
			completion(.failure(AppError.dataMissing))
		})
		apiRequest.makeNetworkCall(
			for: .search(searchText: query),
			with: nil,
			requestType: .get,
			withLoader: true
		)
	}
}
