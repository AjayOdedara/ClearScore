//
//  AttributedStringExtension.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//

import UIKit

extension NSMutableAttributedString {
	
	@discardableResult func medium(_ text: String, color:UIColor = .systemYellow, fontSize:CGFloat = 45) -> NSMutableAttributedString {
		let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: fontSize)!, NSAttributedString.Key.foregroundColor: color]
		let boldString = NSMutableAttributedString(string:text, attributes: attrs)
		append(boldString)
		return self
	}
	
	@discardableResult func normal(_ text: String, color:UIColor = .darkText, fontSize:CGFloat = 20) -> NSMutableAttributedString {
		let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AvenirNext-Regular", size: fontSize)!, NSAttributedString.Key.foregroundColor: color]
		let normal = NSMutableAttributedString(string:text, attributes: attrs)
		append(normal)
		return self
	}
}
