//
//  Result.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

public struct Results<T> {

	public let successResponse: T?
	public let failureResponse: Error?

	init(success: T) {
		successResponse = success
		failureResponse = nil
	}

	init(failure: Error) {
		successResponse = nil
		failureResponse = failure
	}
}
