//
//  PhotosViewController.swift
//  PhotoAlbum
//
//  Created by Erkhaan on 18.09.2021.
//

import UIKit

class PhotosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        let button = UIButton()
        button.setTitle("Open Image", for: .normal)
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

    @objc private func buttonTapped() {
        let vc = ImageViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
