import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.setupViewControllers()
    }
    
    func setupViewControllers() {
        guard self.viewControllers == nil else {
            return
        }
        let aroundVC = AroundPrivilegeViewController.initFromStoryboard()
        let suggestVC = SuggestViewController.initFromStoryboard()
        self.setViewControllers([aroundVC, suggestVC], animated: false)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        }
}
