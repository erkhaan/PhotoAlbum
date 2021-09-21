import Foundation
import UIKit
import SnapKit

class AlbumCell: UITableViewCell {

    // MARK: Properties

    let albumPicture = UIImageView()
    let name = UILabel()
    let activityIndicator = UIActivityIndicatorView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(albumPicture)
        addSubview(name)
        albumPicture.addSubview(activityIndicator)
        configureImageView()
        configureLabel()
        configureActivityIndicator()
        setImageConstraints()
        setLabelConstraints()
        setActivityIndicatorConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func configureImageView() {
        albumPicture.clipsToBounds = true
        albumPicture.contentMode = .scaleAspectFill
        albumPicture.layer.cornerRadius = 5
    }

    private func configureLabel() {
        name.numberOfLines = 0
        name.adjustsFontSizeToFitWidth = true
    }

    private func configureActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }

    private func setImageConstraints() {
        albumPicture.translatesAutoresizingMaskIntoConstraints = false
        albumPicture.snp.makeConstraints { maker in
            maker.width.height.equalTo(100)
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().inset(15)
        }
    }

    private func setLabelConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        name.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(albumPicture).inset(120)
            maker.trailing.equalToSuperview().inset(-15)
        }
    }

    private func setActivityIndicatorConstrains() {
        activityIndicator.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
}
