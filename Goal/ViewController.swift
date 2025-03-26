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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let moreAction = UIContextualAction(style: .normal, title: "") { (_, _, completionHandler) in
            print("Нажата кнопка Подробнее")
            completionHandler(true)
        }
        moreAction.backgroundColor = .green
        moreAction.image = makeSwipeButtonImage(color: .systemBlue, icon: "ellipsis")

      
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (_, _, completionHandler) in
            print("Удаление элемента \(indexPath.row)")
            completionHandler(true)
        }
        deleteAction.backgroundColor = .yellow
        deleteAction.image = makeSwipeButtonImage(color: .systemRed, icon: "trash.fill")

        return UISwipeActionsConfiguration(actions: [deleteAction, moreAction])
    }
    
    func makeSwipeButtonImage(color: UIColor, icon: String) -> UIImage? {
        let size = CGSize(width: 80, height: 80) // Размер кнопки
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            
            // Закруглённая кнопка
            let path = UIBezierPath(roundedRect: rect, cornerRadius: 16)
            color.setFill()
            path.fill()
            
            // Добавляем системную иконку
            if let iconImage = UIImage(systemName: icon)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)) {
                let iconRect = CGRect(
                    x: (size.width - iconImage.size.width) / 2,
                    y: (size.height - iconImage.size.height) / 2,
                    width: iconImage.size.width,
                    height: iconImage.size.height
                )
                iconImage.withTintColor(.white, renderingMode: .alwaysOriginal).draw(in: iconRect)
            }
        }
    }
}
