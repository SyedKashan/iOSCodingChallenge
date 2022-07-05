//
//  BookModel.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation

struct BookModel: Codable {
	
	var key: String?
	var title: String?
	var year: Int?
	var authors: [String]?
	
	enum CodingKeys: String, CodingKey {
		case key = "key"
		case title = "title"
		case year = "first_publish_year"
		case authors = "author_name"
	}
	
	init(from decoder: Decoder) throws {
		do {
			let values = try decoder.container(keyedBy: CodingKeys.self)
			key = try values.decodeIfPresent(String.self, forKey: .key) ?? String()
			title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
			year = try values.decodeIfPresent(Int.self, forKey: .year) ?? Int()
			authors = try values.decodeIfPresent([String].self, forKey: .authors) ?? [String]()
		} catch let DecodingError.typeMismatch(type, context) {
			print("Type '\(type)' mismatch:", context.debugDescription)
			print("codingPath:", context.codingPath)
		} catch {
			print(error)
			print(error.localizedDescription)
		}
	}
}
