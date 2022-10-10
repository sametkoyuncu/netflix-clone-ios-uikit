//
//  Extensions.swift
//  netflix-clone-ios-uikit
//
//  Created by Samet Koyuncu on 27.09.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
