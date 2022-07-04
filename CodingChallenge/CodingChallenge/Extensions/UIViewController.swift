//
//  UIViewController.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import UIKit

extension UIViewController {
	static func top() -> UIViewController {
		guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else { fatalError("No view controller present in app?") }
		var result = rootViewController
		while let viewController = result.presentedViewController {
			result = viewController
		}
		return result
	}
}
