import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "8221965"
    private let vkSdk: VKSdk

    var delegate: AuthServiceDelegate?

    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                self.delegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                self.delegate?.authServiceDidSignInFail()
            }
        }
    }

    // MARK: - VKSdk Delegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        delegate?.authServiceSignIn()
    }

    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }

    // MARK: - VKSdk UIDelegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }


}
