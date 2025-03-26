import UIKit

class ViewController: UIViewController {
    
    var nextMatchTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        nextMatchTable.delegate = self
        nextMatchTable.dataSource = self
        
        nextMatchTable.translatesAutoresizingMaskIntoConstraints = false
       
        nextMatchTable.register(NextMatchTableViewCell.self, forCellReuseIdentifier: "cell")
        nextMatchTable.separatorStyle = .none
        nextMatchTable.backgroundColor = .clear // или любой другой
        
        view.addSubview(nextMatchTable)
        
        NSLayoutConstraint.activate([
            nextMatchTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            nextMatchTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            nextMatchTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            nextMatchTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5),
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NextMatchTableViewCell
        cell.backgroundColor = .clear
        cell.configure(homeTeam: "Real Madrid", awayTeam: "Barselona", homeTeamImage: "real", awayTeamImage: "barsa", time: "19:00", date: "23.03", stadium: "Estadio Nacional de Fútbol", city: "Managua")
        
        return cell
    }
    
    
}
