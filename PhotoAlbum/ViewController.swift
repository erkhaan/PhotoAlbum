import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let token = AccessToken.current, !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        } else {
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
        }
    }
}
