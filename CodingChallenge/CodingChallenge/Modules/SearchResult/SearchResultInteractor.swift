//
//  SearchResultInteractor.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol SearchResultInteractorProtocol {
	func viewDidLoad()
}

extension SearchResultInteractor: SearchResultInteractorProtocol {}

enum StateSearchResult {
	case success([BookModel])
	case empty
}

final class SearchResultInteractor {
	
	private let searchString: String
	private let presenter: SearchResultPresenting?
	
	init(presenter: SearchResultPresenting,
		 with searchText: String
	) {
		self.searchString = searchText
		self.presenter = presenter
	}
	
	func viewDidLoad() {
		let apiRequest = ApiManager<[BookModel]>(successHandler: { [weak self ] (bookData) in
			guard bookData.count > 0 else {
				self?.presenter?.update(with: .empty)
				return
			}
			let bookSlice = bookData.count > 10 ? Array(bookData.prefix(11).self) : bookData
			self?.presenter?.update(with: .success(bookSlice))
		}, nullDataSuccessHandler: { (httpStatusCode: HttpStatusCode) in
			
		}, errorHandler: { (httpStatusCode, errorMessage) in
			
		})
		apiRequest.makeNetworkCall(
			for: .search(searchText: searchString),
			with: nil,
			requestType: .get,
			withLoader: true
		)
	}
}
