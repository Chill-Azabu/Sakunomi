import UIKit
import RxCocoa
import RxSwift

class TabBarController: UITabBarController {
    
    enum TabIndex: Int {
        case home = 0
        case favorite
        case carender
        case profile
        
        var title: String {
            switch self {
            case .home: return "home"
            case .favorite: return "favorite"
            case .carender: return "carender"
            case .profile: return "profile"
            }
        }
        
        var image: UIImage {
            switch self {
            case .home: return UIImage(named: "home")!
            case .favorite: return UIImage(named: "favorite")!
            case .carender: return UIImage(named: "carender")!
            case .profile: return UIImage(named: "profile")!
            }
        }
    }
    
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let favoriteVC = FavoriteViewController()
        let carenderVC = CarenderViewController()
        let profileVC = ProfileViewController()
        
        let homeNavCon = UINavigationController(rootViewController: homeVC)
        let favoriteNavCon = UINavigationController(rootViewController: favoriteVC)
        let carenderNavCon = UINavigationController(rootViewController: carenderVC)
        let profileNavCon = UINavigationController(rootViewController: profileVC)
        
        setViewControllers([homeNavCon, favoriteVC, carenderVC, profileVC], animated: false)
        
        tabBar.unselectedItemTintColor = .lightGray
        setupTitle()
        setupImage()
    }
    
    private func setupTitle() {
        tabBar.items![TabIndex.home.rawValue].title = TabIndex.home.title
        tabBar.items![TabIndex.favorite.rawValue].title = TabIndex.favorite.title
        tabBar.items![TabIndex.carender.rawValue].title = TabIndex.carender.title
        tabBar.items![TabIndex.profile.rawValue].title = TabIndex.profile.title
    }
    
    private func setupImage() {
        tabBar.items![TabIndex.home.rawValue].image = TabIndex.home.image
        tabBar.items![TabIndex.favorite.rawValue].image = TabIndex.favorite.image
        tabBar.items![TabIndex.carender.rawValue].image = TabIndex.carender.image
        tabBar.items![TabIndex.profile.rawValue].image = TabIndex.profile.image
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let vc = HomeViewController()
        navigationController?.popToViewController(vc, animated: true)
    }
}

