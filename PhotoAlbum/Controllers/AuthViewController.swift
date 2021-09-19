import UIKit
import FBSDKLoginKit
import XCoordinator

class AuthViewController: UIViewController {

    // MARK: Router

    var router: UnownedRouter<AuthRoute>!

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.permissions = ["public_profile", "email", "user_photos"]
        view.addSubview(loginButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if let token = AccessToken.current, !token.isExpired, !token.isDataAccessExpired {
            // User is logged in, do work such as go to next view controller.
            router.trigger(.loginSuccessful)
        }
    }
}
