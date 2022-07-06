//
//  UIView.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import UIKit

extension UIView {
	class func fromNib<T: UIView>() -> T {
		return (Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T)!
	}
}
