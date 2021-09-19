import UIKit
import XCoordinator

enum PhotoAlbumRoute: Route {
    case albums
    case photos
    case image
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
        case .photos:
            let photosViewController = PhotosViewController()
            photosViewController.router = unownedRouter
            return .push(photosViewController)
        case .image:
            let imageViewController = ImageViewController()
            return .push(imageViewController)
        }
    }

}
