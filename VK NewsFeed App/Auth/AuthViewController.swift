import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AuthService()
    }

    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
}
