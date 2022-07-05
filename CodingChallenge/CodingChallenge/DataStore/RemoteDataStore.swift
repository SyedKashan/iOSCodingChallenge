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
//				self?.presenter?.update(with: .empty)
				return
			}
			let books = bookData.count > 10 ? Array(bookData.prefix(11).self) : bookData
//			self?.presenter?.update(with: .success(bookSlice))
			completion(.success(books))
		}, nullDataSuccessHandler: { (httpStatusCode: HttpStatusCode) in
//			completion(.failure(Error.emptyData))
		}, errorHandler: { (httpStatusCode, errorMessage) in
//			completion(.failure(Error.emptyData))
		})
		apiRequest.makeNetworkCall(
			for: .search(searchText: query),
			with: nil,
			requestType: .get,
			withLoader: true
		)
	}
}
