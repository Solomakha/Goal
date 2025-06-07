import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func tabBar(didSelect index: Int)
}

final class CustomTabBarView: UIView {
    
    weak var delegate: CustomTabBarDelegate?

    private let stackView = UIStackView()
    
    private let icons: [UIImage?] = [
        UIImage(named: "home"),
        UIImage(named: "stadium"),
        UIImage(named: "favorite"),
        UIImage(named: "statistics")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center

        for (index, icon) in icons.enumerated() {
            let button = UIButton(type: .system)
            button.tag = index
            button.tintColor = .gray
            button.setImage(icon?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func tabTapped(_ sender: UIButton) {
        updateSelection(index: sender.tag)
        delegate?.tabBar(didSelect: sender.tag)
    }

    func updateSelection(index: Int) {
        for (i, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                button.tintColor = i == index ? .systemGreen : .gray
            }
        }
    }
}

