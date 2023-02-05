import UIKit
import SnapKit
import XCoordinator

final class AlbumsViewController: UIViewController {
    
    // MARK: Router
    
    var router: UnownedRouter<PhotoAlbumRoute>!
    
    // MARK: Properties
    
    private var albums: [Album] = []
    private var networkService = NetworkService()
    private let tableView = UITableView()
    private var cache = NSCache<AnyObject, AnyObject>()
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Albums"
        setupTableView()
        fetchAlbums()
        setupRightBarButton()
    }
    
    // MARK: Private methods
    
    private func fetchAlbums() {
        networkService.fetchAlbums { [weak self] data in
            for album in data {
                self?.albums.append(Album(id: album.id, name: album.name))
            }
            self?.tableView.reloadData()
        }
    }
    
    private func setupRightBarButton() {
        let closeButton = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        closeButton.tintColor = .black
        navigationItem.rightBarButtonItem = closeButton
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
    
    @objc private func closeButtonTapped() {
        router.trigger(.logOut)
    }
}

// MARK: Table View Data Source

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func configure(cell: AlbumCell, forItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        cell.name.text = album.name ?? "Untitled"
        cell.albumPicture.image = UIImage(named: "placeholder")
        let cacheObject = cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject)
        if cacheObject != nil {
            guard let image = cacheObject as? UIImage else {
                return
            }
            cell.albumPicture.image = image
        } else {
            cell.activityIndicator.startAnimating()
            networkService.fetchPicture(from: album.id) { [weak self] image in
                cell.albumPicture.image = image
                cell.activityIndicator.stopAnimating()
                self?.cache.setObject(image, forKey: (indexPath as NSIndexPath).row as AnyObject)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "AlbumCell",
            for: indexPath
        ) as? AlbumCell else {
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
        router.trigger(.photos(albums[indexPath.row]))
    }
}
