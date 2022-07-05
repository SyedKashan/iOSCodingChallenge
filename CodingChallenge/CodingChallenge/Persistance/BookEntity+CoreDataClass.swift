//
//  BookEntity+CoreDataClass.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//
//

import Foundation
import CoreData

@objc(BookEntity)
public class BookEntity: NSManagedObject, DatabaseEntity {

	required convenience init(
		apiModel: Identifiable,
		context: NSManagedObjectContext
	) {
		let entity = NSEntityDescription.entity(
			forEntityName: String(describing: BookEntity.self),
			in: context
		)
		self.init(entity: entity!, insertInto: context)
		guard let book = apiModel as? Book else { return }
		id = book.id
		title = book.title
		if let cover = book.cover {
			self.cover = Int32(cover)
		}
		year = Int32(book.year)
		authors = book.authors

	}

	func apiModel() -> Identifiable {
		return Book(
			id: id,
			title: title,
			year: Int(year),
			cover: Int(cover),
			authors: authors)
	}
}
