//
//  RemoteDataStore.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

class RemoteDataStore: DataStore {
	private let urlSession: URLSession

	init(urlSession: URLSession = URLSession.shared) {
		self.urlSession = urlSession
	}

	func fetch(query: String, completion: @escaping (Result<[Book], Error>) -> Void) {

		var components = URLComponents()
		components.scheme = "https"
		components.host = "openlibrary.org"
		components.path = "/search.json/"
		components.queryItems = [URLQueryItem(name: "q", value: query),
								 URLQueryItem(name: "limit", value: "10")]

		let task = URLSession.shared.dataTask(with: components.url!) {(data, response, error) in
			guard let data = data else {
				completion(.failure(DataStoreError.noData))
				return
			}

			do {
				let decoder = JSONDecoder()
				let response = try decoder.decode(ApiResponse.self, from: data)
				completion(.success(response.books))
			} catch {
				completion(.failure(DataStoreError.noData))
			}
		}

		task.resume()
	}
}
