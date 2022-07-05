//
//  ImageService.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import UIKit

protocol Cancellable {

	func cancel()
}

extension URLSessionTask: Cancellable {}

final class ImageService {

	func image(for id: String, completion: @escaping (UIImage?) -> Void) -> Cancellable {

		let url = URL(string: "https://covers.openlibrary.org/b/id/\(id)-M.jpg")
		let dataTask = URLSession.shared.dataTask(with: url!) { data, _, _ in
			// Helper
			var image: UIImage?

			defer {
				// Execute Handler on Main Thread
				DispatchQueue.main.async {
					// Execute Handler
					completion(image)
				}
			}

			if let data = data {
				// Create Image from Data
				image = UIImage(data: data)
			}
		}

		// Resume Data Task
		dataTask.resume()

		return dataTask
	}

}
