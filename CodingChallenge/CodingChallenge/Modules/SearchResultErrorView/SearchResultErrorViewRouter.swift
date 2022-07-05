//
//  SearchResultErrorViewRouter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import UIKit

enum ErrorState {
	case noInternet
	case noData
}

protocol SearchResultErrorViewWireframe {
	func dismissView()
}

extension SearchResultErrorViewRouter: SearchResultErrorViewWireframe {}

final class SearchResultErrorViewRouter {

	var viewController: UIViewController?

	static func createModule(with state: ErrorState) -> UIViewController {

		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard let view = storyboard.instantiateViewController(withIdentifier: String(describing: SearchResultErrorView.self)) as? SearchResultErrorView else {
			fatalError("SearchResultErrorViewRouter unwrapped failed")
		}
		let router = SearchResultErrorViewRouter()
		let presenter = SearchResultErrorViewPresenter(
			router: router
		)
		view.state = state
		view.presenter = presenter
		router.viewController = view
		return view
	}
	
	func dismissView() {
		viewController?.dismiss(animated: true, completion: nil)
	}
}

