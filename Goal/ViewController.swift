import UIKit

class ViewController: UIViewController {
    
    var networkManager: NetworkManager!
        
        init(networkManager: NetworkManager = NetworkManager()) {
            super.init(nibName: nil, bundle: nil)
            self.networkManager = networkManager
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .green
            
            networkManager.getNewMovies(page: 1) { movies, error in
                if let error = error {
                    print(error)
                }
                if let movies = movies {
                    movies.forEach { print($0.title) }
                }
            }
        }
    
}
