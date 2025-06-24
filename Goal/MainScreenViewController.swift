import UIKit

class MainScreenViewController: UIViewController {
    
    private let navigationBar = UINavigationBar()
    
    private let notificationButton = NotificationButton(
        normalImage: UIImage(named: "notification"),
        notificationImage: UIImage(named: "notification_call")
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
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
        
        // Если длина слова меньше firstLettersCount, то красим весь текст первым цветом
        if fullText.count <= firstLettersCount {
            attributedString.addAttribute(.foregroundColor, value: firstColor, range: NSRange(location: 0, length: fullText.count))
            return attributedString
        }
        
        // Красим первые буквы
        attributedString.addAttribute(.foregroundColor, value: firstColor, range: NSRange(location: 0, length: firstLettersCount))
        
        // Красим оставшуюся часть
        attributedString.addAttribute(.foregroundColor, value: remainingColor, range: NSRange(location: firstLettersCount, length: fullText.count - firstLettersCount))
        
        return attributedString
    }
    
}
