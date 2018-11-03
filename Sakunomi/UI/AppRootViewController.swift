
import UIKit

class AppRootViewController: UIViewController {
    
    private var current: UIViewController
    
    init() {
        let launchVC = LaunchViewController.makeInstance()
        self.current = launchVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(current)
        current.view.frame = UIScreen.main.bounds
        view.addSubview(current.view)
        current.didMove(toParentViewController: self)
    }
    
    func showLoginScreen() {
        let loginVC = SignInViewController.makeInstance()
        let new = UINavigationController(rootViewController: loginVC)
        addChildViewController(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParentViewController: self)
        
        current.willMove(toParentViewController: nil)
        current.view.removeFromSuperview()
        current.removeFromParentViewController()
        
        current = new
    }
    
    func showHomeScreen() {
        let homeVC = HomeViewController.makeInstance()
        let new = UINavigationController(rootViewController: homeVC)
        addChildViewController(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParentViewController: self)
        
        current.willMove(toParentViewController: nil)
        current.view.removeFromSuperview()
        current.removeFromParentViewController()
        
        current = new
    }
}
