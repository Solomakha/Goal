import UIKit

class MainScreenViewController: UIViewController {
    
    private let navigationBar = UINavigationBar()
    
    private let notificationButton = NotificationButton(
        normalImage: UIImage(named: "notification"),
        notificationImage: UIImage(named: "notification_call")
    )
    
    // Array of system image names
    let systemImages = ["Bundesliga", "Europa_League", "Italian-Serie-A",
                        "ligue-1", "LL", "premier",
                        "UEFA_Champions_Leagues"]
    let systemColors: [UIColor] = [
        .systemRed,
        .systemGreen,
        .systemBlue,
        .systemOrange,
        .systemYellow,
        .systemPink,
        .systemPurple,
        .systemTeal,
        .systemIndigo,
        .systemGray,
        .systemGray2,
        .systemGray3,
        .systemGray4,
        .systemGray5,
        .systemGray6
    ]
    
    // Lazy initialization of the UICollectionView
    private lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LiveMatchCollectionViewCell.self, forCellWithReuseIdentifier: LiveMatchCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        
        let customTitleView = createCustomTitleView(
            title: "ProMatch",
            logoImage: "football"
        )

        notificationButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        notificationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.receiveNotification()
        }

        let leftItem = UIBarButtonItem(customView: customTitleView)
        navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(customView: notificationButton)
        navigationItem.rightBarButtonItem = rightItem
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createCustomTitleView(title: String, logoImage: String) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 280, height: 60)
        
        let imageContact = UIImageView()
        imageContact.image = UIImage(named: logoImage)
        imageContact.layer.cornerRadius = 20
        imageContact.clipsToBounds = true
        imageContact.frame = CGRect(x: 5, y: 0, width: 40, height: 40)
        view.addSubview(imageContact)
        
        let titleLabel = UILabel()
        titleLabel.attributedText = coloredText(
            fullText: title,
            firstLettersCount: 3,
            firstColor: .orange,
            remainingColor: .black
        )
        
        titleLabel.frame = CGRect(x: 55, y: 0, width: 220, height: 40)
        //nameLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(titleLabel)
        
        return view
    }
    
    func receiveNotification() {
        notificationButton.showNotification(true)
    }
    
    func clearNotification() {
        notificationButton.showNotification(false)
    }
    
    func coloredText(fullText: String, firstLettersCount: Int, firstColor: UIColor, remainingColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if fullText.count <= firstLettersCount {
            attributedString.addAttribute(.foregroundColor, value: firstColor, range: NSRange(location: 0, length: fullText.count))
            return attributedString
        }
        
        attributedString.addAttribute(.foregroundColor, value: firstColor, range: NSRange(location: 0, length: firstLettersCount))
        
        attributedString.addAttribute(.foregroundColor, value: remainingColor, range: NSRange(location: firstLettersCount, length: fullText.count - firstLettersCount))
        
        return attributedString
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.reloadData()
        }
    }
    
    private func setupView() {
        view.addSubview(mainCollectionView)
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            mainCollectionView.heightAnchor.constraint(equalToConstant: 250),
           
            
        ])
    }
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return systemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveMatchCollectionViewCell.identifier, for: indexPath) as! LiveMatchCollectionViewCell
        cell.configure(backgroundColorName: systemColors[indexPath.row], logo: systemImages[indexPath.row])
        //cell.backgroundColor = systemColors[indexPath.row]
        cell.configureMatch(liga: "La Liga", homeTeam: "Real Madrid", awayTeam: "Barselona", homeTeamImage: "real", awayTeamImage: "barsa", time: "1", date: "2", stadium: "Estadio Nacional de Fútbol", city: "Managua")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let size = mainCollectionView.frame.width / 3
        return CGSize(width: mainCollectionView.frame.width, height: mainCollectionView.frame.height)
    }
}

