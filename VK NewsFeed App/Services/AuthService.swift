import Foundation
import VK_ios_sdk

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "8221965"
    private let vkSdk: VKSdk

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
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
            }
        }
    }

    // MARK: - VKSdk Delegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }

    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }

    // MARK: - VKSdk UIDelegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }


}
