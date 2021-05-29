import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupViewControllers() {
        if !(self.viewControllers?.isEmpty ?? false) {
            return
        }
        let aroundVC = AroundPrivilegeViewController.initFromStoryboard()
        self.viewControllers = [aroundVC]
    }
}
