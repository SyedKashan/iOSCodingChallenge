//
//  SearchResultPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol SearchResultPresenting {
	func update(with state: StateSearchResult)
}

extension SearchResultPresenter: SearchResultPresenting {}

final class SearchResultPresenter {
	
	private let view: SearchResultViewControllerProtocol?
	
	init(view: SearchResultViewControllerProtocol) {
		self.view = view
	}
	
	func update(with state: StateSearchResult) {
		view?.update(with: state)
	}
}
