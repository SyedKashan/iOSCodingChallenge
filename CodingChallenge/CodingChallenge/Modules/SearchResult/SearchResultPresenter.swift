//
//  SearchResultPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol SearchResultPresenting {
	func update(with books: [Book])
	func updateNoData()
}

extension SearchResultPresenter: SearchResultPresenting {}

final class SearchResultPresenter {
	
	private let view: SearchResultViewControllerProtocol?
	
	init(view: SearchResultViewControllerProtocol) {
		self.view = view
	}
	
	func update(with books: [Book]) {
		view?.update(with: books)
	}
	
	func updateNoData() {
		
	}
}
