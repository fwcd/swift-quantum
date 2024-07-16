//
//  String+Extensions.swift
//  Quantum
//
//  Created on 25.06.24
//

import Foundation

extension String {
    func pluralized(_ n: Int) -> Self {
        n == 1 ? self : "\(self)s"
    }
}
