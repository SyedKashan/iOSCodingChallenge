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
public class BookEntity: NSManagedObject {

	required convenience init(
		book: Book,
		context: NSManagedObjectContext
	) {
		let entity = NSEntityDescription.entity(
			forEntityName: String(describing: BookEntity.self),
			in: context
		)
		self.init(entity: entity!, insertInto: context)
		id = book.id
		title = book.title
		if let cover = book.cover {
			self.cover = Int32(cover)
		}
		if let year = book.year {
			self.year = Int32(year)
		}
		
		authors = book.authors

	}

	func apiModel() -> Book {
		Book(
			id: id,
			title: title,
			year: Int(year),
			cover: Int(cover),
			authors: authors
		)
	}
}
