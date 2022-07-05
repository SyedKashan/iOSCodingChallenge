//
//  SearchResultErrorView.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import UIKit

public final class SearchResultErrorView: UIViewController {

	var presenter: SearchResultErrorViewPresenting?
	var state: ErrorState?
	
	@IBOutlet weak private var imageView: UIImageView!
	@IBOutlet weak private var messageLabel: UILabel!

	public override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	@IBAction func didTapDismissButton(_ sender: UIButton) {
		presenter?.dismissView()
	}
	
}

extension SearchResultErrorView {
	func setupUI() {
		switch state {
		case .noInternet:
			imageView.image = UIImage(named: "icon_no_wifi")
			messageLabel.text = "no_internet".localized
		case .noData:
			imageView.image = UIImage(named: "icon_sad")
			messageLabel.text = "no_data_found".localized
		default: fatalError(LocalizableConstants.somethingWrong.localized)
		}
	}
}
