//
//  BookTableViewCell.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import UIKit
import Foundation

final class BookTableViewCell: UITableViewCell {

	// MARK: - Properties -
	// MARK: Outlets
	
	@IBOutlet private weak var view: UIView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var yearLabel: UILabel!
	@IBOutlet private weak var authorLabel: UILabel!
	
	// MARK: Overrides
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		setupCell()
    }
}

// MARK: cell configuration
extension BookTableViewCell {
	func setupCell() {
		view.layer.borderWidth = 1
		view.layer.borderColor = UIColor.black.cgColor
		view.layer.cornerRadius = 8
	}
	
	func configureCell(with model: Book) {
		titleLabel.text = model.title
		authorLabel.text = model.authors?.joined(separator: "\n")
		guard let year = model.year else {
			yearLabel.isHidden = true
			return
		}
		yearLabel.text = "\(year)"
	}
}
