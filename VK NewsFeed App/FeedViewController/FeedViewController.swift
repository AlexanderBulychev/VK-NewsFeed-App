import UIKit

class FeedViewController: UIViewController {

let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        networkService.request(path: <#T##String#>, params: <#T##[String : String]#>, completion: <#T##(Data?, Error?) -> Void#>)
    }
}
