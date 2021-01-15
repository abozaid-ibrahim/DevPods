//
//  MessageTextView.swift
//  DevComponents
//
//  Created by abuzeid on 05.01.21.
//

#if canImport(UIKit)

    public protocol MessageTextViewDelegate: NSObjectProtocol {
        func messageTextView(_ textView: MessageTextView, didChangeHeight height: CGFloat)

        func messageTextViewShouldBeginEditing(_ textView: MessageTextView) -> Bool
        func messageTextViewDidBeginEditing(_ textView: MessageTextView)
        func messageTextView(_ textView: MessageTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
        func messageTextView(_ textView: MessageTextView, didChangeText text: String)
        func messageTextView(_ textView: MessageTextView, didEndEditingWithText text: String)
    }

    public class MessageTextView: UITextView {
        private let emptyTextReplacement = " "

        private let paragraphStyle: NSParagraphStyle = {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 4
            return style
        }()

        private lazy var placeholderLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.lineBreakMode = .byTruncatingTail
            return label
        }()

        private lazy var heightConstraint: NSLayoutConstraint = {
            let constraint = heightAnchor.constraint(equalToConstant: 18)
            constraint.isActive = true
            return constraint
        }()

        private var currentHeight: CGFloat {
            get { heightConstraint.constant }
            set {
                let clampedHeight = min(newValue, maxHeight)
                let didChange = clampedHeight != currentHeight
                heightConstraint.constant = clampedHeight
                isScrollEnabled = newValue > maxHeight

                if didChange {
                    messageTextViewDelegate?.messageTextView(self, didChangeHeight: currentHeight)
                }
            }
        }

        private var trimmedText: String? {
            text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        public var maxHeight: CGFloat = 60 {
            didSet {
                currentHeight = min(currentHeight, maxHeight)
            }
        }

        public var visibleText: String {
            return trimmedText ?? ""
        }

        public var attributedPlaceholder: NSAttributedString? {
            didSet {
                placeholderLabel.attributedText = attributedPlaceholder
            }
        }

        public weak var messageTextViewDelegate: MessageTextViewDelegate?

        override public init(frame: CGRect, textContainer: NSTextContainer?) {
            super.init(frame: frame, textContainer: textContainer)
            setupViews()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupViews()
        }

        override public func layoutSubviews() {
            super.layoutSubviews()
            adjustContentHeight()
        }

        private func setupViews() {
            backgroundColor = .white
            isPagingEnabled = false
            isMultipleTouchEnabled = false
            showsHorizontalScrollIndicator = false
            delegate = self

            addSubview(placeholderLabel)
            NSLayoutConstraint.activate([
                placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textContainer.lineFragmentPadding),
                placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                placeholderLabel.firstBaselineAnchor.constraint(equalTo: firstBaselineAnchor),
            ])

            clearText()
        }

        private func adjustContentHeight() {
            currentHeight = sizeThatFits(frame.size).height
        }

        public func clearText() {
            setText("")
        }

        public func setText(_ text: String) {
            let originaltext = visibleText
            var adjustedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            placeholderLabel.isHidden = isFirstResponder || !adjustedText.isEmpty

            if adjustedText.isEmpty, !isFirstResponder {
                adjustedText = emptyTextReplacement
            }

            attributedText = NSAttributedString(string: adjustedText, attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.systemFontSize,
                .foregroundColor: UIColor.darkGray,
            ])

            adjustContentHeight()

            let newText = visibleText
            if originaltext != newText {
                messageTextViewDelegate?.messageTextView(self, didChangeText: newText)
            }
        }
    }

    extension MessageTextView: UITextViewDelegate {
        public func textViewDidChange(_ textView: UITextView) {
            adjustContentHeight()
            messageTextViewDelegate?.messageTextView(self, didChangeText: visibleText)
        }

        public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
            return messageTextViewDelegate?.messageTextViewShouldBeginEditing(self) ?? true
        }

        public func textViewDidBeginEditing(_ textView: UITextView) {
            setText(visibleText)
            messageTextViewDelegate?.messageTextViewDidBeginEditing(self)
        }

        public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return messageTextViewDelegate?.messageTextView(self, shouldChangeTextIn: range, replacementText: text) ?? true
        }

        public func textViewDidEndEditing(_ textView: UITextView) {
            setText(textView.text ?? "")
            messageTextViewDelegate?.messageTextView(self, didEndEditingWithText: visibleText)
        }
    }
#endif
