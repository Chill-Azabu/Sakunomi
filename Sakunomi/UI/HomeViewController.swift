
import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension HomeViewController {
    class func makeInstance() -> HomeViewController {
        let storyBoard = UIStoryboard(name: "HomeViewController", bundle: nil)
        let viewController = storyBoard.instantiateInitialViewController() as! HomeViewController
        return viewController
    }
}
