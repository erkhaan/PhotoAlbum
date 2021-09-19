import UIKit
import SnapKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        let label = UILabel()
        label.text = "Image"
        label.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
}
