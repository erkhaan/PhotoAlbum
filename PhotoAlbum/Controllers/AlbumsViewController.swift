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
            DispatchQueue.main.async {
                for album in data {
                    self.albums.append(Album(id: album.id, name: album.name))
                }
                self.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "AlbumCell")
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

    func configure(cell: AlbumCell, forItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        cell.name.text = album.name
        cell.albumPicture.image = UIImage(named: "placeholder")
        cell.activityIndicator.startAnimating()
        networkService.fetchAlbumPicture(from: album.id) { image in
            DispatchQueue.main.async {
                cell.albumPicture.image = image
                cell.activityIndicator.stopAnimating()
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        configure(cell: cell, forItemAt: indexPath)
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
