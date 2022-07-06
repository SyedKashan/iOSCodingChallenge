//
//  SearchResultViewController.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import UIKit

protocol SearchResultViewControllerProtocol: AnyObject {
	func updateContent(_ books: [Book])
	func updateLoadingState(isLoading: Bool)
	func showError(_ error: ErrorState)
}

final class SearchResultViewController: UIViewController, SearchResultViewControllerProtocol {
	
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
	@IBOutlet private weak var errorView: UIView!
	@IBOutlet private weak var imageViewError: UIImageView!
	@IBOutlet private weak var messageLabel: UILabel!
	
	var interactor: SearchResultInteractorProtocol?
	
	private var books = [Book]()
	private var hidesLoadingIndicator: Bool = true {
		 didSet {
			 guard isViewLoaded else { return }
			 hidesLoadingIndicator ? loadingIndicator.stopAnimating() : loadingIndicator.startAnimating()
		 }
	}
	private var showErrorView: Bool = false {
		didSet {
			guard isViewLoaded else { return }
			errorView.isHidden = !showErrorView
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.tintColor = .black
		tableView.register(UINib(nibName: String(describing: BookTableViewCell.self), bundle: nil),
						   forCellReuseIdentifier: String(describing: BookTableViewCell.self))
		
		interactor?.fetchQuery()
    }
}

// MARK: update state of view
extension SearchResultViewController {
	func updateContent(_ books: [Book]) {
		self.books = books
		tableView.reloadData()
	}
	
	func updateLoadingState(isLoading: Bool) {
		hidesLoadingIndicator = !isLoading
	}
	func showError(_ error: ErrorState) {
		setErrorEmptyView(with: error)
	}
	
	private func setErrorEmptyView(with state: ErrorState) {
		showErrorView = true
		switch state {
		case .noInternet:
			imageViewError.image = UIImage(named: "icon_no_wifi")
			messageLabel.text = LocalizableConstants.noInternet.localized
		case .noData:
			imageViewError.image = UIImage(named: "icon_sad")
			messageLabel.text = LocalizableConstants.noDataFound.localized
		}
	}
}

extension SearchResultViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		books.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath)
		(cell as? BookTableViewCell)?.configureCell(with: books[indexPath.row])
		return cell
	}
}
