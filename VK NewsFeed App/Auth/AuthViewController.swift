import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
//        authService = AuthService()
        authService = AppDelegate.shared().authService
    }

    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
}
