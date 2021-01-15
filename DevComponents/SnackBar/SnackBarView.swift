//
//  SnackBarView.swift
//  DevComponents
//
//  Created by abuzeid on 22.12.20.
//

#if canImport(UIKit)

    public final class SnackBarView: UIView {
        private let heartImageView = UIImageView(image: Icons.heartIcon)
        private let textLabel = UILabel(frame: .zero)

        public init(viewModel: SnackBarViewModel) {
            super.init(frame: .zero)

            heartImageView.image = viewModel.icon
            heartImageView.isHidden = (viewModel.icon == nil)
            heartImageView.tintColor = .uiWhite

            textLabel.text = viewModel.text
            textLabel.numberOfLines = 2

            backgroundColor = .charcoal
            layer.cornerRadius = 3
            layer.masksToBounds = true

            textLabel.textColor = .uiWhite
            textLabel.font = .paragraphP6WhiteLeft

            heartImageView.contentMode = .scaleAspectFit

            let subviews = [heartImageView, textLabel]
            subviews.removeAutoresizingMasks()

            let stackview = UIStackView(arrangedSubviews: subviews)
            stackview.translatesAutoresizingMaskIntoConstraints = false
            stackview.axis = .horizontal
            stackview.alignment = .fill
            stackview.distribution = .fill
            stackview.spacing = 12
            addSubview(stackview)
            textLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

            NSLayoutConstraint.activate([
                heartImageView.widthAnchor.constraint(equalToConstant: 16),
                heartImageView.heightAnchor.constraint(equalToConstant: 16),

                stackview.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                bottomAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 8),
                stackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                trailingAnchor.constraint(equalTo: stackview.trailingAnchor, constant: 16),
            ])
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
#endif
