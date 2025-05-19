import Foundation
import UIKit

class LiveMatchCollectionViewCell: UICollectionViewCell {
    static let identifier = "DemoCollectionViewCell"

    private lazy var matchView: UIView = {
        var matchView = UIView()
        matchView.translatesAutoresizingMaskIntoConstraints = false
        //matchView.backgroundColor = .clear
        matchView.layer.cornerRadius = 25
        matchView.clipsToBounds = true
        matchView.layer.shadowColor = UIColor.black.cgColor
        matchView.layer.shadowOpacity = 0.15
        matchView.layer.shadowOffset = CGSize(width: 0, height: 4)
        matchView.layer.shadowRadius = 8
        
        return matchView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 25
        //imageView.transform = CGAffineTransform(rotationAngle: -15 * CGFloat.pi / 180)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var matchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func homeTeamStackView(imageView: UIImageView, titleLabel: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }
    
    private func awayTeamStackView(imageView: UIImageView, titleLabel: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }
    
    private let homeCommandImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let homeCommandTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let awayCommandImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let awayCommandTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.textAlignment = .center
        label.text = "1-3"
        label.textColor = .white
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onAirView.layer.removeAnimation(forKey: "blink")
        startBlinkingOnAirView()
    }
    
    private let stadiumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(white: 1, alpha: 0.7)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var onAirView: UIView = {
        var onAirView = UIView()
        onAirView.translatesAutoresizingMaskIntoConstraints = false
        onAirView.backgroundColor = .red
        onAirView.layer.cornerRadius = 7.5
        onAirView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        onAirView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        onAirView.clipsToBounds = true
        onAirView.layer.shadowColor = UIColor.black.cgColor
        onAirView.layer.shadowOpacity = 0.15
        onAirView.layer.shadowOffset = CGSize(width: 0, height: 4)
        onAirView.layer.shadowRadius = 8
        return onAirView
    }()
    
    private let liveLabel: UILabel = {
        let liveLabel = UILabel()
        liveLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        liveLabel.text = "Live"
        liveLabel.textColor = .black
        liveLabel.translatesAutoresizingMaskIntoConstraints = false
        return liveLabel
    }()
    
    private let ligaLabel: UILabel = {
        let ligaLabel = UILabel()
        ligaLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        ligaLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ligaLabel.text = "LIGA"
        ligaLabel.textColor = .black
        ligaLabel.translatesAutoresizingMaskIntoConstraints = false
        return ligaLabel
    }()
    
    private lazy var liveStackView: UIStackView = {
        let liveStackView = UIStackView()
        liveStackView.layer.cornerRadius = 15
        liveStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        liveStackView.axis = .horizontal
        liveStackView.spacing = 5
        liveStackView.alignment = .center
        liveStackView.distribution = .equalCentering
        liveStackView.translatesAutoresizingMaskIntoConstraints = false
        return liveStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        matchView.addSubview(imageView)
        matchView.addSubview(containerStackView)
        matchView.addSubview(liveStackView)
        matchView.addSubview(ligaLabel)
        
        let homeStack = homeTeamStackView(imageView: homeCommandImageView, titleLabel: homeCommandTitle)
        let awayStack = awayTeamStackView(imageView: awayCommandImageView, titleLabel: awayCommandTitle)
        
        matchStackView.addArrangedSubview(homeStack)
        matchStackView.addArrangedSubview(resultLabel)
        matchStackView.addArrangedSubview(awayStack)
        
        liveStackView.addArrangedSubview(onAirView)
        liveStackView.addArrangedSubview(liveLabel)
        
        containerStackView.addArrangedSubview(matchStackView)
        containerStackView.addArrangedSubview(stadiumLabel)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(backgroundColorName: UIColor, logo: String) {
        let commandLogo = UIImage(named: "\(logo)")?.withRenderingMode(.alwaysTemplate)
        imageView.image = commandLogo
        imageView.tintColor = UIColor.gray.withAlphaComponent(0.5)
        matchView.backgroundColor = backgroundColorName
    }
    
    func configureMatch(liga: String, homeTeam: String, awayTeam: String, homeTeamImage: String, awayTeamImage: String, time: String, date: String, stadium: String, city: String) {
        homeCommandTitle.text = homeTeam
        awayCommandTitle.text = awayTeam
        homeCommandImageView.image = UIImage(named: homeTeamImage)
        awayCommandImageView.image = UIImage(named: awayTeamImage)
//        timeLabel.text = time
//        dateLabel.text = date
        stadiumLabel.text = "\(stadium), \(city)"
        ligaLabel.text = liga
    }
    
    private func setupView() {
        contentView.addSubview(matchView)
        prepareForReuse()
        NSLayoutConstraint.activate([
            matchView.topAnchor.constraint(equalTo: contentView.topAnchor),
            matchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            matchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            matchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            imageView.centerXAnchor.constraint(equalTo: matchView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: matchView.topAnchor),
            //imageView.centerYAnchor.constraint(equalTo: matchView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            liveStackView.topAnchor.constraint(equalTo: matchView.topAnchor, constant: 10),
            liveStackView.trailingAnchor.constraint(equalTo: matchView.trailingAnchor, constant: -15),
            
            ligaLabel.topAnchor.constraint(equalTo: matchView.topAnchor, constant: 10),
            ligaLabel.leadingAnchor.constraint(equalTo: matchView.leadingAnchor, constant: 15),

            containerStackView.topAnchor.constraint(equalTo: liveStackView.bottomAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: matchView.bottomAnchor, constant: -12),
            containerStackView.leadingAnchor.constraint(equalTo: matchView.leadingAnchor, constant: 5),
            containerStackView.trailingAnchor.constraint(equalTo: matchView.trailingAnchor, constant: -5),
        ])
    }
    
    private func startBlinkingOnAirView() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        onAirView.layer.add(animation, forKey: "blink")
    }
    
}

