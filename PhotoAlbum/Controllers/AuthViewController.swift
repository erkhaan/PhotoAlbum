import UIKit
import FBSDKLoginKit
import XCoordinator
import SnapKit

class AuthViewController: UIViewController {

    // MARK: Router

    var router: UnownedRouter<AuthRoute>!

    // MARK: Properties

    let galleryButton = UIButton()
    let loginButton = FBLoginButton()

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginButton)
        view.addSubview(galleryButton)
        configureFacebookButton()
        configureGalleryButton()
        setFacebookButtonConstraints()
        setGalleryButtonConstraints()
    }

    // MARK: Private methods

    private func configureFacebookButton() {
        loginButton.center = view.center
        loginButton.permissions = ["public_profile", "email", "user_photos"]
    }

    private func configureGalleryButton() {
        galleryButton.backgroundColor = .black
        galleryButton.setTitle("Open gallery", for: .normal)
        galleryButton.layer.cornerRadius = 10
        galleryButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func setFacebookButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(galleryButton).inset(60)
        }
    }

    private func setGalleryButtonConstraints() {
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        galleryButton.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.equalTo(150)
            maker.height.equalTo(50)
        }
    }

    private func checkToken() -> Bool {
        if let token = AccessToken.current, !token.isExpired, !token.isDataAccessExpired {
            return true
        }
        return false
    }

    @objc private func buttonTapped() {
        if checkToken() == true {
            router.trigger(.loginSuccessful)
        } else {
            let alert = UIAlertController(
                title: "Login to Facebook",
                message: nil,
                preferredStyle: .alert
            )
            let action = UIAlertAction(
                title: "Close",
                style: .default,
                handler: nil
            )
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}
