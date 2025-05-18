import UIKit

class ViewController: UIViewController {
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
//        flowLayout.minimumInteritemSpacing = 0
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
        setupView()
    }
    
    // Method to reload the collection view on the main thread
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.reloadData()
        }
    }
    
    // Setup the view and add collection view with constraints
    private func setupView() {
        view.addSubview(mainCollectionView)
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainCollectionView.heightAnchor.constraint(equalToConstant: 250),
            mainCollectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Return the number of items in the collection view section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return systemImages.count
    }
    
    // Configure and return the cell for a given index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveMatchCollectionViewCell.identifier, for: indexPath) as! LiveMatchCollectionViewCell
        cell.configure(backgroundColorName: systemColors[indexPath.row], logo: systemImages[indexPath.row])
        //cell.backgroundColor = systemColors[indexPath.row]
        cell.configureMatch(homeTeam: "Real Madrid", awayTeam: "Barselona", homeTeamImage: "real", awayTeamImage: "barsa", time: "1", date: "2", stadium: "Estadio Nacional de Fútbol", city: "Managua")
        
        return cell
    }
    
    // Return the size for the item at a given index path
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let size = mainCollectionView.frame.width / 3
        return CGSize(width: mainCollectionView.frame.width, height: mainCollectionView.frame.height)
    }

}

