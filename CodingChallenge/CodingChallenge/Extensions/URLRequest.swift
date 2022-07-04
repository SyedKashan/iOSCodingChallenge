//
//  URLRequest.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

extension URLRequest {

	public init(url: String, method: HTTPMethod, header: [String: String]?, body: Any?) {

		guard let requestURL = url.getCleanedURL() else { fatalError("URL is not created") }

		print("Last Called URL: \(requestURL)")
		print("Last Called Para: \(body ?? "")")

		self.init(url: requestURL)
		self.timeoutInterval = 30.0

		self.method = method

		if let header = header {
			header.forEach { self.setValue($0.value, forHTTPHeaderField: $0.key) }
		}

		if let body = body {
			let httpBody: Data
			do {
				httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
				self.httpBody = httpBody
			} catch {
				return
			}
		}
	}
}

extension URLRequest {

	public enum HTTPMethod: String {
		case get = "GET"
		case post = "POST"
	}

	public var method: HTTPMethod? {
		get {
			guard let httpMethod = self.httpMethod else { return nil }
			let method = HTTPMethod(rawValue: httpMethod)
			return method
		}
		set {
			self.httpMethod = newValue?.rawValue
		}
	}
}
