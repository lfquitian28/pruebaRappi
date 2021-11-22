//
//  CGSize+Extension.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import Foundation
import UIKit

extension CGSize {
    var scaledSize: CGSize {
        .init(width: width * UIScreen.main.scale, height: height * UIScreen.main.scale)
    }
}
