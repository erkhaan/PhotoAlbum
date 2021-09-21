import Foundation
import UIKit

class PhotoCell: UITableViewCell {

    // MARK: Properties

    var photoPicture = UIImageView()
    var name = UILabel()
    var uploadDate = UILabel()
    var activityIndicator = UIActivityIndicatorView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(photoPicture)
        addSubview(name)
        addSubview(uploadDate)
        photoPicture.addSubview(activityIndicator)
        configureImageView()
        configureNameLabel()
        configureDateLabel()
        configureActivityIndicator()
        setImageViewConstraints()
        setNameLabelConstraints()
        setDateLabelConstraints()
        setActivityIndicatorConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func configureImageView() {
        photoPicture.clipsToBounds = true
        photoPicture.contentMode = .scaleAspectFill
    }

    private func configureNameLabel() {
        name.numberOfLines = 0
        name.adjustsFontSizeToFitWidth = true
    }

    private func configureDateLabel() {
        uploadDate.numberOfLines = 0
        uploadDate.adjustsFontSizeToFitWidth = true
        uploadDate.font = UIFont.systemFont(ofSize: 12)
        uploadDate.textColor = .lightGray
    }

    private func configureActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }

    private func setImageViewConstraints() {
        photoPicture.translatesAutoresizingMaskIntoConstraints = false
        photoPicture.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(100)
            maker.leading.equalToSuperview().inset(12)
        }
    }

    private func setNameLabelConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        name.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview().inset(-20)
            maker.leading.equalTo(photoPicture).inset(120)
            maker.trailing.equalToSuperview().inset(-12)
        }
    }

    private func setDateLabelConstraints() {
        uploadDate.translatesAutoresizingMaskIntoConstraints = false
        uploadDate.snp.makeConstraints { maker in
            maker.top.equalTo(name).inset(20)
            maker.leading.equalTo(photoPicture).inset(120)
            maker.trailing.equalToSuperview().inset(-12)
        }
    }

    private func setActivityIndicatorConstraints() {
        activityIndicator.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
}
