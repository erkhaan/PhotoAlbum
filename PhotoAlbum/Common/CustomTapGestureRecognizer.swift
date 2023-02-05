import Foundation
import UIKit

final class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var indexPath: IndexPath
    init(indexPath: IndexPath, target: Any?, selector: Selector?) {
        self.indexPath = indexPath
        super.init(target: target, action: selector)
    }
}
