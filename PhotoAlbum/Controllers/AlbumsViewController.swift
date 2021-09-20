import UIKit
import SnapKit
import XCoordinator

class AlbumsViewController: UIViewController {

    // MARK: Router

    var router: UnownedRouter<PhotoAlbumRoute>!

    // MARK: Properties

    private var albums: [Album] = []

    private var networkService = NetworkService()

    let tableView = UITableView()

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Albums"
        setupTableView()
        fetchAlbums()
    }

    // MARK: Private methods

    private func fetchAlbums() {
        networkService.fetchAlbums { [weak self] data in
            guard let self = self else { return }
            for album in data {
                self.albums.append(Album(id: album.id, name: album.name))
            }
            self.tableView.reloadData()
        }
    }

    /*private func fetchAlbumPictureUrl() {
        for i in albums.indices {
            networkService.fetchAlbumImage(from: albums[i].id) { [weak self] url in
                guard let self = self else { return }
                self.albums[i].url = url
                print(url)
            }
        }
    }*/

    private func setupTableView() {
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
        cell.imageView?.backgroundColor = .systemTeal
        cell.imageView?.image = UIImage(named: "sample")
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
