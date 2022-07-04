//
//  ApiClient.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

public typealias URLResponse = Result<(data: Data, response: HTTPURLResponse), Error>

open class APIClient {

	public init() { }

	open func dataTask(_ request: URLRequest,
					   completionHandler: @escaping (URLResponse) -> Void) -> URLSessionDataTask {

		let task = URLSession.shared.dataTask(with: request) { data, response, error in

			if let data = data, let response = response as? HTTPURLResponse {
				completionHandler(.success((data, response)))
			} else {
				#if DEBUG
				print("Error is \(error!)")
				#endif
				let error = error ?? NSError(domain: "com.kashan.network", code: 9999, userInfo: [:])
				completionHandler(.failure(error))
			}
		}
		task.resume()
		return task
	}
}
