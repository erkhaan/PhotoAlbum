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
        setupViews()
        setupTableView()
    }

    // MARK: Private methods

    private func setupViews() {
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

    private func setupTableView() {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 120
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.bottom.top.left.right.equalToSuperview()
        }
    }

    @objc private func buttonTapped() {
        router.trigger(.photos)
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
