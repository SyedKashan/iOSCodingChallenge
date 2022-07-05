//
//  LandingViewController.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 04/07/2022.
//

import UIKit

protocol LandingViewControllerProtocol: AnyObject {
	
}

extension LandingViewController: LandingViewControllerProtocol,
								 UITextFieldDelegate {}

class LandingViewController: UIViewController {
	
	// MARK: - Properties -
	// MARK: Outlets
	
	@IBOutlet private weak var searchTextfield: UITextField!
	@IBOutlet private weak var searchButton: UIButton!
	
	// MARK: Internal
	private var interactor: LandingInteractorProtocol?
	
	// MARK: - Functions -
	// MARK: Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		setupUI()
		setupNavigation()
		
		interactor = LandingInteractor(
			presenter: LandingPresenter(view: self)
		)
	}
	
	// MARK: IBActions
	
	@IBAction func didTapSearchButton(_ sender: UIButton) {
	}
}

// MARK: UI Setup
extension LandingViewController {
	
	func setupNavigation() {
		
		let imageView = UIImageView(image: UIImage(named: "icon_polestar_nav"))
		self.navigationItem.titleView = imageView
	}
	
	func setupUI() {
		
		searchButton.layer.borderColor = UIColor.black.cgColor
		searchButton.layer.borderWidth = 1
		searchButton.layer.cornerRadius = 8
	}
	
}

// MARK: Textfield Delegate
extension LandingViewController {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
	}
}
