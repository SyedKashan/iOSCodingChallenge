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
	
	@IBOutlet weak var coverImage: UIImageView!
	@IBOutlet private weak var view: UIView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var yearLabel: UILabel!
	@IBOutlet private weak var authorLabel: UILabel!
	
	private lazy var imageService = ImageService()
	private var imageRequest: Cancellable?
	
	// MARK: Overrides
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		setupCell()
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		coverImage.image = nil
		imageRequest?.cancel()
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
		authorLabel.text = model.authors.joined(separator: "\n")
		if let year = model.year {
			yearLabel.isHidden = false
			yearLabel.text = "\(year)"
		} else {
			yearLabel.isHidden = true
		}
		if let cover = model.cover, cover != 0 {
			// Request Image Using Image Service
			imageRequest = imageService.image(for: "\(cover)") { [weak self] image in
				// Update Image View
				self?.coverImage.image = image
			}
		} else {
			coverImage.image = UIImage(named: "icon_polestar")
		}
	}
}
