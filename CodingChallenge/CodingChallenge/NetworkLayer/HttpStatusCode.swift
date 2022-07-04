//
//  HttpStatusCode.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

enum HttpStatusCode {
	case success, unauthorized, validation, failure, serverError, unknown
}

extension Int {
	var status: HttpStatusCode {
		switch self {
		case 200,201:
			return .success
		case 401:
			return .unauthorized
		case 422:
			return .validation
		case 400...421, 423...499:
			return .failure
		case 500...599:
			return .serverError
		default:
			return .unknown
		}
	}
}
