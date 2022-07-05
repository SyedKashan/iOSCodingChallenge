//
//  LandingPresenter.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol LandingPresenting: AnyObject {
	
}

class LandingPresenter: LandingPresenting {
	
	private let view: LandingViewControllerProtocol?
	
	init(view: LandingViewControllerProtocol) {
		self.view = view
	}
	
}
