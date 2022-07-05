//
//  SearchResultErrorViewPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol SearchResultErrorViewPresenting {
	func dismissView()
}

extension SearchResultErrorViewPresenter: SearchResultErrorViewPresenting {}

final class SearchResultErrorViewPresenter {
	
	private var router: SearchResultErrorViewWireframe?
	
	init(router: SearchResultErrorViewWireframe) {
		self.router = router
	}
	
	func dismissView() {
		router?.dismissView()
	}
}
