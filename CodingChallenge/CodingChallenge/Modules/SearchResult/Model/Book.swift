//
//  Book.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

struct Book: Identifiable, Codable {
	
	enum CodingKeys: String, CodingKey {
		case id = "key"
		case title = "title"
		case year = "first_publish_year"
		case authors = "author_name"
		case cover = "cover_i"
	}
	var id: String
	let title: String
	let year: Int?
	let authors: [String]
	let cover: Int?
	
	init(id: String,
		 title: String,
		 year: Int?,
		 cover: Int?,
		 authors: [String]
	) {
		self.id = id
		self.title = title
		self.year = year
		self.authors = authors
		self.cover = cover
	}
}

