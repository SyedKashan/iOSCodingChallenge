//
//  LandingInteractor.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol LandingInteractorProtocol {
	func validate(with searchText: String?)
}

extension LandingInteractor: LandingInteractorProtocol {}

struct ErrorModel {
	let title: String
	let errorMessage: String
}

enum State {
	case valid
	case error(ErrorModel)
}

final class LandingInteractor {
	
	private let presenter: LandingPresenting?
	
	init(presenter: LandingPresenting) {
		self.presenter = presenter
	}
	
	func validate(with searchText: String?) {
		guard let searchText = searchText,
			!searchText.isEmpty else {
				presenter?.update(with: .error(ErrorModel(
					title: LocalizableConstants.validationError.localized,
					errorMessage: LocalizableConstants.emptyString.localized))
				)
			return
		}
		if searchText.count <= 3 {
			presenter?.update(with: .error(ErrorModel(
				title: LocalizableConstants.validationError.localized,
				errorMessage: LocalizableConstants.minLength.localized))
			)
		} else {
			presenter?.routeToSearchResult(with: searchText)
		}
	}
}
