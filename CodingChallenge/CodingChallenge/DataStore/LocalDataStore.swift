//
//  LocalDataStore.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import CoreData

class LocalDataStore: DataStore {
	static let shared = LocalDataStore()
	private lazy var persistentContainer: NSPersistentContainer = {
		NSPersistentContainer(name: "CodingChallenge")
	}()
	
	private var managedObjectContext: NSManagedObjectContext?
	var isStorageReady = false

	init() {
		prepareLocalStorage()
	}
	
	func prepareLocalStorage() {
		persistentContainer.loadPersistentStores { descriptor, error in
			self.isStorageReady = error == nil
		}
	}
	
	func fetch(
		query: String,
		completion: @escaping (Result<[Book], Error>) -> Void
	) {
		let fetchRequest: NSFetchRequest<BookEntity>
		fetchRequest = BookEntity.fetchRequest()

		fetchRequest.predicate = NSPredicate(
			format: "title CONTAINS %@", query
		)

		let context = persistentContainer.viewContext
		
		do {
			let results = try context.fetch(fetchRequest)
			guard !results.isEmpty else {
				completion(.failure(DataStoreError.noData))
				return
			}
			let books = results.compactMap{ $0.apiModel() }
			completion(.success(books))
		} catch {
			completion(.failure(DataStoreError.noData))
		}
	}
	
	func save(
		items: [Book]
	) {
		guard isStorageReady
		else {
			print("storage is not ready to use")
			return
		}
		let managedObjectContext = persistentContainer.viewContext
		items.forEach {
			_ = BookEntity(
				book: $0,
				context: managedObjectContext
			)
		}
		do {
			try managedObjectContext.save()
		} catch {
			print("Unable to save data, we can do error handling here as well.")
		}
	}
}
