//
//  SearchResultPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol SearchResultPresenting {
	func update(with state: SearchResultState)
}

enum SearchResultState {
	case loaded([Book])
	case loading
	case noData
	case noConnection
}

final class SearchResultPresenter: SearchResultPresenting {
	
	private weak var view: SearchResultViewControllerProtocol?
	
	init(view: SearchResultViewControllerProtocol) {
		self.view = view
	}
	
	func update(with state: SearchResultState) {
		DispatchQueue.main.async { [weak self] in
			switch state {
			case .loaded(let books):
				self?.view?.updateLoadingState(isLoading: false)
				self?.view?.updateContent(books)
			case .loading:
				self?.view?.updateLoadingState(isLoading: true)
			case .noData:
				self?.view?.updateLoadingState(isLoading: false)
				self?.view?.showError(.noData)
			case .noConnection:
				self?.view?.updateLoadingState(isLoading: false)
				self?.view?.showError(.noInternet)
			}
		}
	}
}
