import UIKit
import SnapKit
import XCoordinator

class AlbumsViewController: UIViewController {

    // MARK: Router
    var router: UnownedRouter<PhotoAlbumRoute>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        let label = UILabel()
        label.text = "Albums"
        label.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        let button = UIButton()
        button.setTitle("Open Photos", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(label).inset(150)
            maker.width.equalTo(150)
            maker.height.equalTo(50)
        }
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        router.trigger(.photos)
    }
}
