//
//  SearchResultViewController.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import UIKit

protocol SearchResultViewControllerProtocol {
	func update(with books: [Book])
	func update(with state: StateSearchResult)
}

extension SearchResultViewController: SearchResultViewControllerProtocol,
									  UITableViewDataSource {}

final class SearchResultViewController: UIViewController {
	
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
	
	var interactor: SearchResultInteractorProtocol?
	
	private var books = [Book]()
	private var hidesLoadingIndicator: Bool = true {
		 didSet {
			 guard isViewLoaded else { return }
			 loadingIndicator.isHidden = hidesLoadingIndicator
			 hidesLoadingIndicator ? loadingIndicator.stopAnimating() : loadingIndicator.startAnimating()
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
	
	func update(with books: [Book]) {
		DispatchQueue.main.async {
			self.books = books
			self.tableView.reloadData()
		}
	}
	
	func update(with state: StateSearchResult) {
		DispatchQueue.main.async { [weak self] in
			switch state {
			case .loaded(let books):
				self?.hidesLoadingIndicator = true
				self?.books = books
				self?.tableView.reloadData()
			case .loading:
				self?.hidesLoadingIndicator = false
			case .noData:
				self?.hidesLoadingIndicator = true
			case .noConnection:
				self?.hidesLoadingIndicator = true
			}
		}
	}
}

extension SearchResultViewController {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		books.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookTableViewCell.self)) as? BookTableViewCell else {
			fatalError(LocalizableConstants.bookCellInstantiate)
		}
		cell.configureCell(with: books[indexPath.row])
		return cell
	}
}
