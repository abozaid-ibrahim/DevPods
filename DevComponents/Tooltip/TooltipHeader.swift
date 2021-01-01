//
//  TooltipHeader.swift
//  UIComponents
//
//  Created by abuzeid on 22.12.20.
//
import UIComponents

private enum Constants {
    static let leftPadding: CGFloat = 8
    static let rightPadding: CGFloat = 8
    static let topPadding: CGFloat = 12
    static let bottomPadding: CGFloat = 12
    static let spacing: CGFloat = 4
}

public final class TooltipHeader: UIView {
    public var action: (() -> Void)?
    
    private let contentView = UIView(frame: .zero)
    private let logoImageView = UIImageView(frame: .zero)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = .paragraphP5DarkLeft
        label.textColor = .charcoal
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.font = .paragraphP5DarkCentre
        label.textColor = .charcoal
        return label
    }()
    
    public init?(configuration: TooltipConfigurationProtocol) {
        super.init(frame: .zero)
        
        logoImageView.image = #imageLiteral(resourceName: "happy")
        titleLabel.attributedText = configuration.titleAttributedString
        subtitleLabel.attributedText = configuration.subtitleAttributedString
        
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        contentView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        
        let subviews = [logoImageView, titleLabel, subtitleLabel]
        subviews.removeAutoresizingMasks()
        
        contentView.addSubviews(subviews)
        addSubview(contentView)
        
        contentView.backgroundColor = .blueLight
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        logoImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.heightAnchor.constraint(lessThanOrEqualToConstant: 75),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            logoImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Constants.leftPadding),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightPadding),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Constants.leftPadding),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.spacing),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapActionButton))
        subtitleLabel.addGestureRecognizer(tapRecognizer)
        subtitleLabel.isUserInteractionEnabled = true
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapActionButton(sender: Any?) {
        action?()
    }
    
}

public protocol DynamicHeightHeaderView: class {
    func height(forWidth width: CGFloat) -> CGFloat
}

extension TooltipHeader: DynamicHeightHeaderView {
    public func height(forWidth width: CGFloat) -> CGFloat {
        layoutIfNeeded()
        
        subviews.forEach { subview in
            if let label = subview as? UILabel {
                label.preferredMaxLayoutWidth = width - Constants.leftPadding - Constants.rightPadding
            }
        }
        
        return systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
    }
}
