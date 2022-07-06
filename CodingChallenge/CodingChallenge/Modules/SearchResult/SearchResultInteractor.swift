//
//  SearchResultInteractor.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol SearchResultInteractorProtocol {
	func fetchQuery()
}

final class SearchResultInteractor: SearchResultInteractorProtocol {
	
	private let searchString: String
	private let presenter: SearchResultPresenting?
	private let localDataStore = LocalDataStore.shared
	private let remoteDataStore = RemoteDataStore()
	
	init(presenter: SearchResultPresenting,
		 with searchText: String
	) {
		self.searchString = searchText
		self.presenter = presenter
	}
	
	func fetchQuery() {
		presenter?.update(with: .loading)
		localDataStore.fetch(query: searchString) {[weak self] result in
			switch result {
			case .success(let books):
				books.isEmpty
					? self?.fetchFromRemote()
					: self?.presenter?.update(with: .loaded(books))
			case .failure:
				self?.fetchFromRemote()
			}
		}
	}
	
	private func fetchFromRemote() {
		remoteDataStore.fetch(query: searchString) { [weak self] result in
			switch result {
			case .success(let books):
				guard !books.isEmpty else {
					self?.presenter?.update(with: .noData)
					return
				}
				self?.presenter?.update(with: .loaded(books))
				self?.localDataStore.save(items: books)
			case .failure(let error):
				
				if case DataStoreError.noInternet = error {
					self?.presenter?.update(with: .noConnection)
				} else {
					self?.presenter?.update(with: .noData)
				}
			}
		}
	}
}

