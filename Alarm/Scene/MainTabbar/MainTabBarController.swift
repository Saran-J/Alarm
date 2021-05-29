import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewControllers()
    }
    
    func setupViewControllers() {
        if !(self.viewControllers?.isEmpty ?? false) {
            return
        }
    }
}
