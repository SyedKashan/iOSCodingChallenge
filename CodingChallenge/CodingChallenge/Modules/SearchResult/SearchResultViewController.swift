//
//  SearchResultViewController.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import UIKit

protocol SearchResultViewControllerProtocol {
	func update(with state: StateSearchResult)
}

extension SearchResultViewController: SearchResultViewControllerProtocol,
									  UITableViewDataSource {}

final class SearchResultViewController: UIViewController {
	
	// MARK: - Properties -
	// MARK: Outlets
	@IBOutlet private weak var tableView: UITableView!
	
	// MARK: Internal
	var interactor: SearchResultInteractorProtocol?
	
	// MARK: Private
	private var state: StateSearchResult?
	
	// MARK: - Functions -
	// MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

		setupNavigation()
		setupUI()
		
		interactor?.viewDidLoad()
    }
}

// MARK: UI Setup
extension SearchResultViewController {
	func setupNavigation() {
		
//		self.navigationController?.navigationBar.barStyle = .black
		self.navigationController?.navigationBar.tintColor = .black
	}
	
	func setupUI() {
		tableView.register(UINib(nibName: Constants.bookTableViewCell, bundle: nil),
						   forCellReuseIdentifier: Constants.bookTableViewCell)
	}
}

// MARK: update state of view
extension SearchResultViewController {
	
	func update(with state: StateSearchResult) {
		DispatchQueue.main.async {
			self.state = state
			self.tableView.reloadData()
		}
	}
}

extension SearchResultViewController {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch state {
		case .success(let books): return books.count
		default: return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.bookTableViewCell) as? BookTableViewCell else {
			fatalError(LocalizableConstants.bookCellInstantiate)
		}
		switch state {
		case .success(let books):
			cell.configureCell(with: books[indexPath.row])
		default: fatalError(LocalizableConstants.logicError)
		}
		return cell
	}
}
