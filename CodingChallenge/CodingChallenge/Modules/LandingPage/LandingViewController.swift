//
//  LandingViewController.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 04/07/2022.
//

import UIKit

protocol LandingViewControllerProtocol {
	func update(with state: State)
}

extension LandingViewController: LandingViewControllerProtocol,
								 UITextFieldDelegate {}

final class LandingViewController: UIViewController {
	
	@IBOutlet private weak var searchTextfield: UITextField!
	@IBOutlet private weak var searchButton: UIButton!
	
	private var interactor: LandingInteractorProtocol?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		let imageView = UIImageView(image: UIImage(named: "icon_polestar_nav"))
		self.navigationItem.titleView = imageView
		
		interactor = LandingInteractor(
			presenter: LandingPresenter(view: self,
										router: LandingRouter(view: self))
		)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		searchTextfield.becomeFirstResponder()
	}
}

extension LandingViewController {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
		interactor?.validate(with: searchTextfield.text)
		return true
	}
}

extension LandingViewController {
	
	func update(with state: State) {
		switch state {
		case .valid: break
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
