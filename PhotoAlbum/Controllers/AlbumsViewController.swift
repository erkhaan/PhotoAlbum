import UIKit
import SnapKit
import XCoordinator

class AlbumsViewController: UIViewController {

    // MARK: Router

    var router: UnownedRouter<PhotoAlbumRoute>!

    // MARK: Properties

    private var albums: [Album] = [
        Album(imageName: "sample", name: "Cats01Cats01Cats01Cats01Cats01Cats01Cats01Cats01"),
        Album(imageName: "sample", name: "Cats02"),
        Album(imageName: "sample", name: "Cats03"),
        Album(imageName: "sample", name: "Cats04"),
        Album(imageName: "sample", name: "Cats05")]

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Albums"
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

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let album = albums[indexPath.row]
        cell.imageView?.image = UIImage.init(named: album.imageName)
        cell.textLabel?.text = album.name
        return cell
    }
}

// MARK: Table View Delegate

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router.trigger(.photos)
    }
}
