//
//  LandingInteractor.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

protocol LandingInteractorProtocol: AnyObject {
	
}

class LandingInteractor: LandingInteractorProtocol {
	
	private let presenter: LandingPresenting?
	
	init(presenter: LandingPresenting) {
		self.presenter = presenter
	}
	
}
