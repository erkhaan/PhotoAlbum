import UIKit
import SnapKit

class ImageViewController: UIViewController {

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    // MARK: Private methods

    private func setupViews() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sample")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.bottom.left.right.equalToSuperview()
        }
        let infoButton = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .done,
            target: self,
            action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem = infoButton
    }

    @objc private func infoButtonTapped() {
        let alert = UIAlertController(
            title: "Photo Info",
            message: "Additional photo info",
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "Close",
            style: .default,
            handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
