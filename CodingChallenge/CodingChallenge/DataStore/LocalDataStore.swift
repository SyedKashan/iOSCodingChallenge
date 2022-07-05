//
//  LocalDataStore.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import CoreData

class LocalDataStore: DataStore {
	
	private lazy var persistentContainer: NSPersistentContainer = {
			NSPersistentContainer(name: "CodingChallenge")
		}()
	
	func fetch(
		query: String,
		completion: @escaping (Result<[Book], Error>) -> Void
	) {
		let fetchRequest: NSFetchRequest<BookEntity>
		fetchRequest = BookEntity.fetchRequest()

		fetchRequest.predicate = NSPredicate(
			format: "title LIKE %@", query
		)

		let context = persistentContainer.viewContext
		
		do {
			let results = try context.fetch(fetchRequest)
			if results.count > 0 {
				let books = results.compactMap{ $0.apiModel() }
				completion(.success(books))
			} else {
				completion(.failure(DataStoreError.noData))
			}
		} catch {
			fatalError("fetch request for entity Book predicate failed")
		}
	}
	
	func save(
		items: [Book]
	) {
//		DispatchQueue.global(qos: .background) {
			let context = persistentContainer.viewContext
			items
				.compactMap { BookEntity.init(book: $0, context: context)}
				.forEach { context.insert($0) }
//		}
	}
}
