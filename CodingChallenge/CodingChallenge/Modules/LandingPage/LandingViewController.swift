//
//  LandingViewController.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 04/07/2022.
//

import UIKit

protocol LandingViewControllerProtocol: AnyObject {
	func update(with state: State)
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
		interactor?.validate(with: searchTextfield.text)
	}
}

// MARK: UI Setup
extension LandingViewController {
	
	private func setupNavigation() {
		
		let imageView = UIImageView(image: UIImage(named: "icon_polestar_nav"))
		self.navigationItem.titleView = imageView
	}
	
	private func setupUI() {
		
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

// MARK: update state of view
extension LandingViewController {
	
	func update(with state: State) {
		switch state {
		case .valid:
			break
		case .error(let errorModel):
			presentAlert(with: errorModel)
		}
	}
	
	private func presentAlert(with errorModel: ErrorModel) {
		let alertViewController = UIAlertController(
			title: errorModel.title,
			message: errorModel.errorMessage,
			preferredStyle: .alert
		)
		let dismissButton = UIAlertAction(
			title: LocalizableConstants.dismiss.localized,
			style: .default,
			handler: nil)
		alertViewController.addAction(dismissButton)
		self.present(alertViewController,
					 animated: true,
					 completion: nil)
	}
}
