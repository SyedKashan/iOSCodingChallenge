//
//  SearchResultRouter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import UIKit

final class SearchResultRouter {

	var viewController: UIViewController?

	static func createModule(with searchText: String) -> UIViewController {

		// Change to get view from storyboard if not using progammatic UI
		let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
		guard let view = storyboard.instantiateViewController(withIdentifier: Constants.searchResultViewController) as? SearchResultViewController else {
			fatalError("SearchResultViewController unwrapped failed")
		}
		let presenter = SearchResultPresenter(view: view)
		let interactor = SearchResultInteractor(presenter: presenter,
												with: searchText)
		
		view.interactor = interactor

		return view
	}
}
