import UIKit
import SnapKit
import XCoordinator

class PhotosViewController: UIViewController {

    // MARK: Router

    var router: UnownedRouter<PhotoAlbumRoute>!

    // MARK: Properties

    private var photos: [Photo] = [
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya"),
        Photo(imageName: "sample", name: "Cat", uploadData: "segodnya")]

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 120
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.bottom.top.left.right.equalToSuperview()
        }
    }
}

// MARK: Table View Data Source

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let photo = photos[indexPath.row]
        cell.imageView?.image = UIImage.init(named: photo.imageName)
        cell.textLabel?.text = photo.name
        cell.detailTextLabel?.text = photo.uploadData
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
