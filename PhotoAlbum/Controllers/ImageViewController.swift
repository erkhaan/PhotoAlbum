import UIKit
import SnapKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sample")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.bottom.left.right.equalToSuperview()
        }
    }
}
