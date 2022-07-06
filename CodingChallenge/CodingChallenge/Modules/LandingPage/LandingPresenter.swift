//
//  LandingPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol LandingPresenting {
	func update(with state: LandingViewState)
	func routeToSearchResult(with searchText: String)
}

final class LandingPresenter: LandingPresenting {

	private let view: LandingViewControllerProtocol?
	private let router: LandingWireframe?
	
	init(view: LandingViewControllerProtocol,
		 router: LandingWireframe
	) {
		self.view = view
		self.router = router
	}
	
	func update(with state: LandingViewState) {
		switch state {
		case.error(let errorModel):
			view?.showErrror(with: errorModel)
		default: break
		}
	}
	
	func routeToSearchResult(with searchText: String) {
		router?.routeToSearchResult(with: searchText)
	}
	
}
