//
//  LandingPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol LandingPresenting: AnyObject {
	func update(with state: State)
}

extension LandingPresenter: LandingPresenting {}

class LandingPresenter {

	private let view: LandingViewControllerProtocol?
	
	init(view: LandingViewControllerProtocol) {
		self.view = view
	}
	
	func update(with state: State) {
		view?.update(with: state)
	}
	
}
