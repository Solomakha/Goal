import UIKit

class TeamTableViewCell: UITableViewCell {

    let positionLabel = UILabel()
    let logoImageView = UIImageView()
    let nameLabel = UILabel()
    let starImageView = UIImageView()
    let gamesPlayedLabel = UILabel()
    let goalDiffLabel = UILabel()
    let pointsLabel = UILabel()
    let leftBarView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        // MARK: - Base Setup
        contentView.backgroundColor = .black

        // MARK: - Label Styling
        [positionLabel, nameLabel, gamesPlayedLabel, goalDiffLabel, pointsLabel].forEach {
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }

        // MARK: - Star
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .yellow
        starImageView.isHidden = true
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        starImageView.setContentHuggingPriority(.required, for: .horizontal)
        starImageView.setContentCompressionResistancePriority(.required, for: .horizontal)

        // MARK: - Logo
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        logoImageView.setContentHuggingPriority(.required, for: .horizontal)
        logoImageView.setContentCompressionResistancePriority(.required, for: .horizontal)

        // MARK: - Left Bar
        leftBarView.backgroundColor = .systemPink
        leftBarView.layer.cornerRadius = 2

        // MARK: - Layout Stacks
        let infoStack = UIStackView(arrangedSubviews: [gamesPlayedLabel, goalDiffLabel, pointsLabel])
        infoStack.axis = .horizontal
        infoStack.spacing = 20
        infoStack.alignment = .center
        infoStack.distribution = .equalSpacing

        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail

        let nameStack = UIStackView(arrangedSubviews: [logoImageView, nameLabel, starImageView])
        nameStack.axis = .horizontal
        nameStack.spacing = 8
        nameStack.alignment = .center
        nameStack.distribution = .fill

        let mainStack = UIStackView(arrangedSubviews: [positionLabel, nameStack, infoStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        mainStack.distribution = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        // MARK: - Add Subviews
        contentView.addSubview(leftBarView)
        contentView.addSubview(mainStack)
        leftBarView.translatesAutoresizingMaskIntoConstraints = false

        // MARK: - Constraints
        NSLayoutConstraint.activate([
            leftBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            leftBarView.widthAnchor.constraint(equalToConstant: 4),
            leftBarView.heightAnchor.constraint(equalToConstant: 30),
            leftBarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            mainStack.leadingAnchor.constraint(equalTo: leftBarView.trailingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    func configure(with team: Team) {
        positionLabel.text = "\(team.position)"
        nameLabel.text = team.name
        logoImageView.image = team.logo
        gamesPlayedLabel.text = "\(team.gamesPlayed)"
        goalDiffLabel.text = "\(team.goalDifference)"
        pointsLabel.text = "\(team.points)"
        starImageView.isHidden = !team.isFavorite
        leftBarView.isHidden = team.position > 3
    }
}
