import UIKit
import SnapKit

class ImageViewController: UIViewController {

    // MARK: Properties

    var photoId: String?
    private let imageView = UIImageView()
    private let networkService = NetworkService()
    private var photoNode = PhotoNode(id: "", height: 0, width: 0, createdTime: "", images: [Image]())

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        fetchPhotoNode()
    }

    // MARK: Private methods

    private func fetchImage() {
        networkService.fetchImage(from: photoNode.images[0].url) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
            }
        }
    }

    private func fetchPhotoNode() {
        guard let id = photoId else {
            print("Photo id not found")
            return
        }
        networkService.fetchPhotoNode(from: id) { data in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.photoNode = PhotoNode(
                    id: data.id,
                    height: data.height,
                    width: data.width,
                    createdTime: data.createdTime,
                    images: data.images
                )
                self.fetchImage()
            }
        }
    }

    private func setupViews() {
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.bottom.left.right.equalToSuperview()
        }
        let infoButton = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .done,
            target: self,
            action: #selector(infoButtonTapped)
        )
        navigationItem.rightBarButtonItem = infoButton
    }

    @objc private func infoButtonTapped() {
        let alert = UIAlertController(
            title: "Photo Info",
            message: "Additional photo info",
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
