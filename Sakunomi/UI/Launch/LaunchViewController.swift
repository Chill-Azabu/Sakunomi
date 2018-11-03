
import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension LaunchViewController {
    
    class func makeInstance() -> LaunchViewController {
        let storyboard = UIStoryboard(name: "LaunchViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! LaunchViewController
        return viewController
    }
}
