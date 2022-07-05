//
//  KeyedDecode.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

public extension KeyedDecodingContainer {
	func decode<T: Decodable>(at key: K) throws -> T {
		try decode(T.self, forKey: key)
	}

	func decode<T: Decodable>(at key: K, or fallback: @autoclosure () -> T) throws -> T {
		let value: T? = try decodeIfPresent(T.self, forKey: key)
		return value ?? fallback()
	}

	func decodeIfPresent<T: Decodable>(at key: K) throws -> T? {
		try decodeIfPresent(T.self, forKey: key)
	}
}
