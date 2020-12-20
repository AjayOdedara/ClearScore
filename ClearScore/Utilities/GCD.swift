//
//  Utility.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import UIKit

class GCD {
    static func runOnMainThread(closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
