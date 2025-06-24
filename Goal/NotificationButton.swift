import UIKit

class NotificationButton: UIButton {
    
    private var normalImage: UIImage?
    private var notificationImage: UIImage?
    
    init(normalImage: UIImage?, notificationImage: UIImage?) {
        super.init(frame: .zero)
        
        self.normalImage = normalImage
        self.notificationImage = notificationImage
        
        self.setImage(normalImage, for: .normal)
        self.layer.borderWidth = 0.1
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    @objc private func didPressDown() {
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @objc private func didRelease() {
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    func showNotification(_ hasNotification: Bool) {
        self.setImage(hasNotification ? notificationImage : normalImage, for: .normal)
    }
}

