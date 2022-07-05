//
//  BookEntity+CoreDataProperties.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }
	
	@NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var cover: Int32
    @NSManaged public var year: Int32
    @NSManaged public var authors: [String]

}
