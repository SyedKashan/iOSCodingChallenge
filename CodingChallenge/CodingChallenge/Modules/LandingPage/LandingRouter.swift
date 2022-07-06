//
//  LandingRouter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import UIKit

protocol LandingWireframe {
	func routeToSearchResult(with searchText: String)
}

extension LandingRouter: LandingWireframe {}

final class LandingRouter {

	let view: UIViewController?
	init(view: UIViewController) {
		self.view = view
	}
}

extension LandingRouter {
	
	func routeToSearchResult(with searchText: String) {
		let controller = SearchResultRouter.createModule(with: searchText)
		view?.navigationController?.pushViewController(controller, animated: true)
	}
}
