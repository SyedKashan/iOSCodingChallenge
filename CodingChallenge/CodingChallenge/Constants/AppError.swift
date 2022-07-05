//
//  AppError.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

enum AppError: Error {
	
	case dataMissing
}

extension AppError {
	var title: String {
		"uh_oh_alert_title".localized
	}

	var message: String {
		switch self {
		case .dataMissing:
			return "no_data_found".localized
		}
	}
}
