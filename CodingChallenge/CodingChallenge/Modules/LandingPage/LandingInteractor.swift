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

final class LandingInteractor: LandingInteractorProtocol {
	
	private let presenter: LandingPresenting
	private let validator: Validator
	
	init(
		presenter: LandingPresenting,
		validator: Validator = Validator()
	) {
		self.validator = validator
		self.presenter = presenter
	}
	
	func validate(with searchText: String?) {
		switch validator.validate(searchText) {
			case .success(let searchText):
				presenter.routeToSearchResult(with: searchText)
			case .failure(let error):
				presenter.update(with: .error(ErrorModel(
					title: error.title,
					errorMessage: error.message)))
		}
	}
}
