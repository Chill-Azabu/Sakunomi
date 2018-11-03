
import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SignInViewController {
    
    class func makeInstance() -> SignInViewController {
        let storyboard = UIStoryboard(name: "SignInViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! SignInViewController
        return viewController
    }
}
