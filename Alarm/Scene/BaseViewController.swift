import UIKit
import JGProgressHUD

protocol BaseViewControllerProtocol: class {
    func displayMessage(title: String, message: String)
    func displayMessageWithCallback(
        title: String,
        message: String,
        callback: @escaping () -> Void
    )
    func displayLoading(_ message: String)
    func hideLoading()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    let hud = JGProgressHUD()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayMessage(title: String, message: String) {
        let alert = AlertBuilder()
            .setTitle(title)
            .setMessage(message)
            .setOkButtn("ok", callback: {})
            .build()
        present(alert, animated: true, completion: nil)
    }
    
    func displayMessageWithCallback(
        title: String,
        message: String,
        callback: @escaping () -> Void
    ) {
        let alert = AlertBuilder()
            .setTitle(title)
            .setMessage(message)
            .setOkButtn("ok", callback: callback)
            .build()
        present(alert, animated: true, completion: nil)
    }
    
    func displayLoading(_ message: String = "") {
        hud.textLabel.text = message
        hud.show(in: self.view)
    }
    
    func hideLoading() {
        hud.dismiss()
    }
}

class AlertBuilder {
    let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    func setTitle(_ title: String) -> AlertBuilder {
        alertVC.title = title
        return self
    }
    
    func setMessage(_ message: String) -> AlertBuilder {
        alertVC.message = message
        return self
    }
    
    func setOkButtn(_ buttonTitle: String, callback: @escaping () -> Void?) -> AlertBuilder {
        alertVC.addAction(
            UIAlertAction(
                title: buttonTitle,
                style: .default,
                handler: { _ in
                    callback()
                }
            )
        )
        return self
    }
    
    func build() -> UIAlertController {
        return alertVC
    }
}
