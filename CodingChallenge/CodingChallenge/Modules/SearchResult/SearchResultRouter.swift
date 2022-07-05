//
//  SearchResultRouter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import UIKit

protocol SearchResultWireframe {
	func routeToErrorView(with state: ErrorState)
}

extension SearchResultRouter: SearchResultWireframe {}

final class SearchResultRouter {

	var viewController: UIViewController?

	static func createModule(with searchText: String) -> UIViewController {

		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard let view = storyboard.instantiateViewController(withIdentifier: String(describing: SearchResultViewController.self)) as? SearchResultViewController else {
			fatalError("SearchResultViewController unwrapped failed")
		}
		let router = SearchResultRouter()
		let presenter = SearchResultPresenter(view: view,
											  router: router)
		let interactor = SearchResultInteractor(presenter: presenter,
												with: searchText)
		
		view.interactor = interactor
		router.viewController = view

		return view
	}
	
	func routeToErrorView(with state: ErrorState) {
		let controller = SearchResultErrorViewRouter.createModule(with: state)
		controller.modalPresentationStyle = .fullScreen
		viewController?.present(
			controller,
			animated: true,
			completion: { [weak self] in
				self?.viewController?.navigationController?.popViewController(animated: false)
			}
		)
	}
}

