import UIKit
import RxSwift
import RxCocoa

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    let router = PublishRelay<UIViewController>()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        bindingRouter()
        self.setupStyle()
        self.setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupStyle() {
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(
                name: "KrungthaiFast-Regular", size: 16
            ) as Any
        ]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
    
    func bindingRouter() {
        router.bind { viewController in
            self.navigationController?.pushViewController(
                viewController,
                animated: true
            )
        }
        .disposed(by: disposeBag)
    }
    
    func setupViewControllers() {
        guard self.viewControllers == nil else {
            return
        }
        
        let suggestVC = SuggestViewController.initFromStoryboard()
        suggestVC.onRoute.bind(to: router).disposed(by: disposeBag)
        
        let investVC = InvestmentViewController.initFromStoryboard()
        investVC.onRoute.bind(to: router).disposed(by: disposeBag)
        
        let contactVC = ContactViewController.initFromStoryboard()
        contactVC.onRoute.bind(to: router).disposed(by: disposeBag)
        
        let profileVC = ProfileViewController.initFromStoryboard()
        profileVC.onRoute.bind(to: router).disposed(by: disposeBag)
        
        self.setViewControllers([suggestVC, investVC, contactVC, profileVC], animated: false)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(
            red: 0,
            green: 166 / 255,
            blue: 230 / 255,
            alpha: 1)
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        let safeAreaHeight: CGFloat = {
            if UIDevice.current.isIphoneXSeries() {
                if #available(iOS 11.0, *) {
                    return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
                } else {
                    return 0
                }
            }
            return 0
        }()
        tabBar.frame.size.height = 70 + safeAreaHeight
        tabBar.frame.origin.y = view.frame.height - (70 + safeAreaHeight)
        tabBar.items?.forEach({ item in
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5.0)
        })
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        if fromView != toView {
            UIView.transition(
                from: fromView,
                to: toView,
                duration: 0.3,
                options: [.transitionCrossDissolve],
                completion: nil
            )
        }
        
        return true
    }
}
