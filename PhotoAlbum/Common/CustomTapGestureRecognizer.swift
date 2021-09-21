//
//  CustomTapGestureRecognizer.swift
//  PhotoAlbum
//
//  Created by Erkhaan on 22.09.2021.
//

import Foundation
import UIKit

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var indexPath: IndexPath
    init(indexPath: IndexPath, target: Any?, selector: Selector?) {
        self.indexPath = indexPath
        super.init(target: target, action: selector)
    }
}
