//
//  LandingPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol LandingPresenting {
	func update(with state: State)
	func routeToSearchResult(with searchText: String)
}

extension LandingPresenter: LandingPresenting {}

final class LandingPresenter {

	private let view: LandingViewControllerProtocol?
	private let router: LandingWireframe?
	
	init(view: LandingViewControllerProtocol,
		 router: LandingWireframe
	) {
		self.view = view
		self.router = router
	}
	
	func update(with state: State) {
		view?.update(with: state)
	}
	
	func routeToSearchResult(with searchText: String) {
		router?.routeToSearchResult(with: searchText)
	}
	
}
