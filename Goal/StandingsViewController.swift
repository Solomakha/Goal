import UIKit

class StandingsViewController: UIViewController {
    
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Турнирная таблица"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor =  .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    private var viewWithTable: UIView = {
        let viewWithTable = UIView()
        viewWithTable.translatesAutoresizingMaskIntoConstraints = false
        viewWithTable.backgroundColor = .white
        viewWithTable.layer.cornerRadius = 25
        return viewWithTable
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: "TeamCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    var teams: [Team] = []
    
    func loadTeams() {
        // Загрузить реальные изображения и данные
        teams = [
            Team(position: 1, name: "Arsenal", logo: UIImage(named: "favorite")!, gamesPlayed: 14, goalDifference: 22, points: 37, isFavorite: true),
            Team(position: 2, name: "Manchester City", logo: UIImage(named: "home")!, gamesPlayed: 14, goalDifference: 26, points: 32, isFavorite: false),
            // Добавить остальные команды...
        ]
        tableView.reloadData()
    }
    
    
    //
    //    private let subView1: UIView = {
    //        let view = UIView()
    //        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
    //        view.backgroundColor = UIColor.blue
    //        return view
    //    }()
    //
    //    private let subview2: UIView = {
    //        let view = UIView()
    //        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
    //        view.backgroundColor = UIColor.cyan
    //        return view
    //    }()
    //
    //    private let subview3: UIView = {
    //        let view = UIView()
    //        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
    //        view.backgroundColor = UIColor.gray
    //        return view
    //    }()
    //
    //    private func setupScrollView() {
    ////        let margins = view.layoutMarginsGuide
    //        viewWithTable.addSubview(scrollView)
    //
    //        scrollView.addSubview(scrollStackViewContainer)
    //        scrollView.leadingAnchor.constraint(equalTo: viewWithTable.leadingAnchor).isActive = true
    //        scrollView.trailingAnchor.constraint(equalTo: viewWithTable.trailingAnchor).isActive = true
    //        scrollView.topAnchor.constraint(equalTo: viewWithTable.topAnchor).isActive = true
    //        scrollView.bottomAnchor.constraint(equalTo: viewWithTable.bottomAnchor).isActive = true
    //        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    //        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    //        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    //        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    //        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    //        configureContainerView()
    //    }
    //
    //    private func configureContainerView() {
    //        scrollStackViewContainer.addArrangedSubview(subView1)
    //        scrollStackViewContainer.addArrangedSubview(subview2)
    //        scrollStackViewContainer.addArrangedSubview(subview3)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(headerLabel)
        self.view.addSubview(viewWithTable)
        viewWithTable.addSubview(tableView)
        
        addConstraints()
        loadTeams()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            viewWithTable.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            //
            viewWithTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            viewWithTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            viewWithTable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            viewWithTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            tableView.topAnchor.constraint(equalTo: viewWithTable.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: viewWithTable.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: viewWithTable.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: viewWithTable.bottomAnchor),
            
        ])
    }
}

extension StandingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as? TeamTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: teams[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        header.backgroundColor = .gray
        return header
    }
}
