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
	let year: Int
	let authors: [String]
	let cover: Int?
	
	init(id: String,
		 title: String,
		 year: Int,
		 cover: Int?,
		 authors: [String]
	) {
		self.id = id
		self.title = title
		self.year = year
		self.authors = authors
		self.cover = cover
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(at: .id)
		title = try values.decode(at: .title)
		year = try values.decode(at: .year)
		authors = try values.decode(at: .authors)
		cover = try? values.decodeIfPresent(at: .cover)
	}
}

