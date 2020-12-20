//
//  Result.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation

enum Result<T, E: Error> {
	case success(T)
	case failure(E)
}
