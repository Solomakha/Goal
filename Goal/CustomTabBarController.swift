import UIKit

final class CustomTabBarController: UIViewController {

    private let tabBarView = CustomTabBarView()
    private let containerView = UIView()
    
    private let viewControllers: [UIViewController] = [
        MainScreenViewController(),
        ResultsViewController(),
        FavoriteViewController(),
        StatisticViewController()
    ]

    private var currentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        switchToViewController(index: 0)
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        tabBarView.delegate = self
        view.addSubview(tabBarView)
        
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.backgroundColor = .orange
        tabBarView.layer.cornerRadius = 35.5
        
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            tabBarView.heightAnchor.constraint(equalToConstant: 70),

            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func switchToViewController(index: Int) {
        currentVC?.willMove(toParent: nil)
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()

        let vc = viewControllers[index]
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(vc.view)

        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        vc.didMove(toParent: self)

        currentVC = vc
        tabBarView.updateSelection(index: index)
    }
}

extension CustomTabBarController: CustomTabBarDelegate {
    func tabBar(didSelect index: Int) {
        switchToViewController(index: index)
    }
}

