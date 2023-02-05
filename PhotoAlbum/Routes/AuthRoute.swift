import UIKit
import XCoordinator

enum AuthRoute: Route {
    case loginSuccessful
}

final class AuthCoordinator: ViewCoordinator<AuthRoute> {

    // MARK: Initialization

    init() {
        let viewController = AuthViewController()
        super.init(rootViewController: viewController, initialRoute: nil)
        viewController.router = unownedRouter
    }

    // MARK: Overrides

    override func prepareTransition(for route: AuthRoute) -> ViewTransition {
        switch route {
        case .loginSuccessful:
            let coordinator = PhotoAlbumCoordinator()
            coordinator.rootViewController.modalPresentationStyle = .fullScreen
            return .present(coordinator)
        }
    }
}
