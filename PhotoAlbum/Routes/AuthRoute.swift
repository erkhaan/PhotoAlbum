import UIKit
import XCoordinator

enum AuthRoute: Route {
    case loginSuccessful
}

class AuthCoordinator: ViewCoordinator<AuthRoute> {
    // MARK: Initialization

    init() {
        let viewController = AuthViewController()
        super.init(rootViewController: viewController)
        viewController.router = unownedRouter
    }

    override func prepareTransition(for route: AuthRoute) -> ViewTransition {
        switch route {
        case .loginSuccessful:
            let vc = AlbumsViewController()
            vc.modalPresentationStyle = .fullScreen
            return .present(vc)
        }
    }
}
