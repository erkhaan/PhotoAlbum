import UIKit
import XCoordinator

enum PhotoAlbumRoute: Route {
    case albums
    case photos(Album)
    case image(String)
    case logOut
}

class PhotoAlbumCoordinator: NavigationCoordinator<PhotoAlbumRoute> {

    // MARK: Initialization

    init() {
        super.init(initialRoute: .albums)
    }

    // MARK: Overrides

    override func prepareTransition(for route: PhotoAlbumRoute) -> NavigationTransition {
        switch route {
        case .albums:
            let albumsViewController = AlbumsViewController()
            albumsViewController.router = unownedRouter
            return .push(albumsViewController)
        case let .photos(album):
            let photosViewController = PhotosViewController()
            photosViewController.router = unownedRouter
            photosViewController.currentAlbum = album
            return .push(photosViewController)
        case let .image(id):
            let imageViewController = ImageViewController()
            imageViewController.photoId = id
            return .push(imageViewController)
        case .logOut:
            return .dismiss()
        }
    }

}
