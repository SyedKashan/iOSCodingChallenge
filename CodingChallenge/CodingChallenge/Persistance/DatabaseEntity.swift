//
//  DatabaseEntity.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import CoreData
import Foundation

protocol DatabaseEntity: Identifiable {
	init(apiModel: Identifiable, context: NSManagedObjectContext)
	func apiModel() -> Identifiable
}

public protocol Identifiable {
	var id: String { get }
}
