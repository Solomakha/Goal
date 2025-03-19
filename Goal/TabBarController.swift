import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        self.selectedIndex = 0
        self.tabBar.tintColor = .systemGreen
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTabs() {
        let home = self.createNav(with: "", and: UIImage(named: "home"), vc: MainScreenViewController())
        let results = self.createNav(with: "", and: UIImage(named: "stadium"), vc: ResultsViewController())
        let fav = self.createNav(with: "", and: UIImage(named: "favorite"), vc: FavoriteViewController())
        let stats = self.createNav(with: "", and: UIImage(named: "statistics"), vc: StatisticViewController())
        
        self.setViewControllers([home, results, fav, stats], animated: true)
    }
    
    private func createNav (with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController (rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}
