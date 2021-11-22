//
//  AppAppearance.swift
//  PruebaRappi
//
//  Created by luis quitan on 13/11/21.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
       
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
