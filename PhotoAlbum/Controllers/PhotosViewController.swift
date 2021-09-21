import UIKit
import SnapKit
import XCoordinator

class PhotosViewController: UIViewController {

    // MARK: Router

    var router: UnownedRouter<PhotoAlbumRoute>!

    // MARK: Properties

    var currentAlbum: Album? {
        didSet {
            reloadData()
        }
    }

    private var photos: [Photo] = [
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadDate: "segodnya")]

    // MARK: View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }

    // MARK: Private methods

    private func setupTableView() {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhotoCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.rowHeight = 120
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.bottom.top.left.right.equalToSuperview()
        }
    }

    private func reloadData() {
        loadViewIfNeeded()
        title = currentAlbum?.name
    }
}

// MARK: Table View Data Source

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UITableViewCell()
        }
        let photo = photos[indexPath.row]
        cell.photoPicture.image = UIImage(named: "placeholder")
        cell.name.text = photo.name
        cell.uploadDate.text = photo.uploadDate
        return cell
    }
}

// MARK: Table View Delegate

extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router.trigger(.image)
    }
}
