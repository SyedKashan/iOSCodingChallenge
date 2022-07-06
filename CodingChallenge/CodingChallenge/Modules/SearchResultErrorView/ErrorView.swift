//
//  ErrorView.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import UIKit

enum ErrorState {
	case noInternet, noData
}

class ErrorView: UIView {

	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func updateView(with state: ErrorState) {
		switch state {
		case .noInternet:
			imageView.image = UIImage(named: "icon_no_wifi")
			messageLabel.text = "no_internet".localized
		case .noData:
			imageView.image = UIImage(named: "icon_sad")
			messageLabel.text = "no_data_found".localized
		}
	}
}
