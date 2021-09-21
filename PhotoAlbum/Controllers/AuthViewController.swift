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

    // comment: Try to move token validation to viewDidLoad

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if let token = AccessToken.current, !token.isExpired, !token.isDataAccessExpired {
            // User is logged in, do work such as go to next view controller.
            router.trigger(.loginSuccessful)
        }
    }

}

extension AuthViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("asdf")
        router.trigger(.loginSuccessful)
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}
