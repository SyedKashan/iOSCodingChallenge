//
//  RemoteDataStore.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import SystemConfiguration

class RemoteDataStore: DataStore {
	private let urlSession: URLSession
	
	init(
		urlSession: URLSession = URLSession.shared
	) {
		self.urlSession = urlSession
	}

	func fetch(
		query: String,
		fetchLimit: Int = Constants.fetchLimit,
		completion: @escaping (Result<[Book], Error>) -> Void
	) {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "openlibrary.org"
		components.path = "/search.json/"
		components.queryItems = [URLQueryItem(name: "q", value: query),
								 URLQueryItem(name: "limit", value: "\(fetchLimit)")]

		let task = URLSession.shared.dataTask(with: components.url!) {(data, response, error) in
			guard let data = data else {
				self.isInternetAvailable() ? completion(.failure(DataStoreError.noData)) : completion(.failure(DataStoreError.noInternet))
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
	
	func isInternetAvailable() -> Bool {
		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
		zeroAddress.sin_family = sa_family_t(AF_INET)
		
		let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
				SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
			}
		}
		
		var flags = SCNetworkReachabilityFlags()
		if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
			return false
		}
		let isReachable = flags.contains(.reachable)
		let needsConnection = flags.contains(.connectionRequired)
		return (isReachable && !needsConnection)
	}
}

