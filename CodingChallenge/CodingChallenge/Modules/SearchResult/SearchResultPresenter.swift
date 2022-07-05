//
//  SearchResultPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol SearchResultPresenting {
	func update(with books: [Book])
	func update(with state: StateSearchResult)
	func updateNoData()
}

extension SearchResultPresenter: SearchResultPresenting {}

final class SearchResultPresenter {
	
	private let view: SearchResultViewControllerProtocol?
	private let router: SearchResultWireframe?
	
	init(view: SearchResultViewControllerProtocol, router: SearchResultWireframe) {
		self.view = view
		self.router = router
	}
	
	func update(with books: [Book]) {
//		view?.update(with: books)
	}
	
	func updateNoData() {
		DispatchQueue.main.async {
			self.router?.routeToErrorView(with: .noData)
		}
	}
	
	func update(with state: StateSearchResult) {
		view?.update(with: state)
	}
}
