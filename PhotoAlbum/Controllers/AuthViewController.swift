import UIKit
import FBSDKLoginKit

class AuthViewController: UIViewController {

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
            let vc = AlbumsViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
