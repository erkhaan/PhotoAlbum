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
        if let token = AccessToken.current, !token.isExpired, !token.isDataAccessExpired {
            // User is logged in, do work such as go to next view controller.
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.router.trigger(.loginSuccessful)
            }
        } else {
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email", "user_photos"]
            view.addSubview(loginButton)
        }
    }
}

extension AuthViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.trigger(.loginSuccessful)
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}
