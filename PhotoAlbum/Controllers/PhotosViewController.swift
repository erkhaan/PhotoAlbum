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

    private var photos: [Photo] = []
    private var networkService = NetworkService()
    private let tableView = UITableView()
    private var cache = NSCache<AnyObject, AnyObject>()

    // MARK: View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        fetchPhotos()
    }

    // MARK: Private methods

    private func fetchPhotos() {
        guard let id = currentAlbum?.id else {
            print("Album id not found")
            return
        }
        networkService.fetchPhotos(from: id) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                for photo in data {
                    self.photos.append(Photo(id: photo.id, name: photo.name, uploadDate: photo.uploadDate))
                }
                self.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
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

    @objc private func photoPictureTapped(_ sender: CustomTapGestureRecognizer) {
        router.trigger(.image(photos[sender.indexPath.row].id))
    }
}

// MARK: Table View Data Source

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }

    func configure(cell: PhotoCell, forItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        cell.name.text = photo.name
        cell.uploadDate.text = photo.uploadDate
        cell.photoPicture.image = UIImage(named: "placeholder")
        cell.selectionStyle = .none
        let tapRecognizer = CustomTapGestureRecognizer(
            indexPath: indexPath,
            target: self,
            selector: #selector(photoPictureTapped(_:)))
        cell.photoPicture.addGestureRecognizer(tapRecognizer)
        let cacheObject = cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject)
        if cacheObject != nil {
            guard let image = cacheObject as? UIImage else {
                return
            }
            cell.photoPicture.image = image
        } else {
            cell.activityIndicator.startAnimating()
            networkService.fetchPicture(from: photo.id) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    cell.photoPicture.image = image
                    cell.activityIndicator.stopAnimating()
                    self.cache.setObject(image, forKey: (indexPath as NSIndexPath).row as AnyObject)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UITableViewCell()
        }
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
}
