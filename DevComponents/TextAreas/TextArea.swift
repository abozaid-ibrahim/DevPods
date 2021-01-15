//
//  TextArea.swift
//  DevComponents
//
//  Created by abuzeid on 22.12.20.
//
#if canImport(UIKit)

    @objc public protocol TextAreaDelegate: ResizableTextViewDelegate {}

    @objc public final class TextArea: NibView {
        @IBOutlet var titleLabel: UILabel!
        @IBOutlet var errorLabel: UILabel!
        @IBOutlet var textView: ResizableTextView!
        @IBOutlet var underline: UIView!
        @IBOutlet var statusImage: UIImageView!
        @IBOutlet var contentView: UIView!
        @IBOutlet var counterLabel: UILabel!

        @IBOutlet var heightConstraint: NSLayoutConstraint!

        let placeholderColor: UIColor = .grey5
        let textColor: UIColor = .charcoal
        let counterColor: UIColor = .grey5
        let disabledContentViewColor: UIColor = .grey3

        public var contentViewColor: UIColor = .grey2 {
            didSet {
                if contentViewColor == oldValue {
                    return
                }
                redraw()
            }
        }

        @objc public weak var delegate: TextAreaDelegate?

        override public var isFirstResponder: Bool {
            return textView.isFirstResponder
        }

        override public func becomeFirstResponder() -> Bool {
            textView.becomeFirstResponder()
        }

        @objc public var selectedTextRange: UITextRange? {
            get { textView.selectedTextRange }
            set { textView.selectedTextRange = newValue }
        }

        override public var isAccessibilityElement: Bool {
            get { textView.isAccessibilityElement }
            set { textView.isAccessibilityElement = newValue }
        }

        override public var accessibilityLabel: String? {
            get { textView.accessibilityLabel }
            set { textView.accessibilityLabel = newValue }
        }

        override public var accessibilityIdentifier: String? {
            get { textView.accessibilityIdentifier }
            set { textView.accessibilityIdentifier = newValue }
        }

        @objc public var visibleText: String {
            return textView.visibleText
        }

        @objc public var currentHeight: CGFloat {
            return textView.currentHeight
        }

        @objc public var maxLength: Int {
            get { state.maxLength }
            set {
                if state.maxLength == newValue {
                    return
                }
                var newState = state
                newState.maxLength = newValue

                state = newState
            }
        }

        @objc public var isEditable: Bool {
            return textView.isEditable
        }

        @objc public var editable: Bool {
            get { return textView.isEditable }
            set { textView.isEditable = newValue }
        }

        public var state = State() {
            didSet(newValue) {
                if state == newValue {
                    return
                }
                redraw()
            }
        }

        @objc public var title: String? {
            get { state.title }
            set {
                if state.title == newValue {
                    return
                }
                var newState = state
                newState.title = newValue

                state = newState
            }
        }

        @objc public var error: String? {
            get { state.error }
            set {
                if state.error == newValue {
                    return
                }
                var newState = state
                newState.error = newValue

                state = newState
            }
        }

        @objc public func setup(text: String, textColor: UIColor? = .charcoal, placeholder: NSAttributedString? = nil) {
            textView.contentInset = .zero

            var newState = state
            newState.value = text
            newState.placeholder = placeholder?.string

            state = newState
        }

        @objc public func refreshHeight() -> CGFloat {
            return textView.refreshHeight()
        }

        private func redraw() {
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0

            titleLabel.textColor = textColor
            textView.textColor = textColor
            errorLabel.textColor = .error
            counterLabel.textColor = counterColor
            underline.backgroundColor = .grey5

            textView.resizableTextViewDelegate = self

            titleLabel.text = state.title
            textView.maxLength = state.maxLength
            let value = state.value ?? ""
            if textView.text != value {
                textView.update(text: value)
            }
            errorLabel.text = state.error
            errorLabel.textColor = .error
            switch state.status {
            case .none:
                statusImage.tintColor = .clear
                statusImage.isHidden = true
                titleLabel.textColor = .grey5
                underline.backgroundColor = .grey5
                contentView.backgroundColor = contentViewColor
            case .error:
                statusImage.image = Icons.thickWarning
                statusImage.tintColor = .error
                statusImage.isHidden = false
                titleLabel.textColor = .error
                underline.backgroundColor = .error
                contentView.backgroundColor = contentViewColor
            case .valid:
                statusImage.image = Icons.thickTick
                statusImage.tintColor = .tealPrimary
                statusImage.isHidden = false
                titleLabel.textColor = .grey5
                underline.backgroundColor = .grey5
                contentView.backgroundColor = contentViewColor
            case .disabled:
                statusImage.image = nil
                statusImage.tintColor = .tealPrimary
                statusImage.isHidden = true
                titleLabel.textColor = .grey5
                underline.backgroundColor = .grey5
                contentView.backgroundColor = disabledContentViewColor
            }
            textView.isUserInteractionEnabled = state.status != .disabled
            underline.isHidden = !state.focused

            let length = (state.value ?? "").lengthOfBytes(using: .utf8)
            counterLabel.text = state.status != .error ? "\(length)/\(state.maxLength)" : nil
            heightConstraint.constant = max(TextArea.State.defaultHeight, state.height)

            let placeholder = state.placeholder.map {
                NSAttributedString(string: $0, attributes: [
                    .foregroundColor: placeholderColor,
                    .font: UIFont.systemFont(ofSize: 16),
                ])
            }

            textView.setup(text: state.value ?? "", textColor: textColor, placeholder: placeholder)
        }

        @objc public func caretRect(forPosition position: UITextPosition) -> CGRect {
            return textView.caretRect(for: position)
        }

        @objc public func setDoneButtonToolbar(text: String = "Done", target: Any? = nil, action: Selector? = nil) {
            textView.setDoneButtonToolbar(text: text, target: target, action: action)
        }
    }

    extension TextArea: ResizableTextViewDelegate {
        public func resizableTextViewDidBeginEditing(_ textView: ResizableTextView) {
            let newState = state

            newState.focused = true
            newState.value = textView.text
            state = newState

            delegate?.resizableTextViewDidBeginEditing?(textView)
        }

        public func resizableTextViewDidEndEditing(_ text: String) {
            let newState = state

            newState.focused = false
            newState.value = textView.text

            state = newState

            delegate?.resizableTextViewDidEndEditing?(text)
        }

        public func resizableTextViewDidChange(_ textView: ResizableTextView) {
            delegate?.resizableTextViewDidChange?(textView)

            if state.value == textView.text {
                return
            }

            state.value = textView.text

            redraw()
        }

        public func resizableTextViewDidChangeHeight(_ textView: ResizableTextView) {
            let newState = state

            newState.height = textView.currentHeight
            newState.value = textView.text
            state = newState

            setNeedsLayout()
            delegate?.resizableTextViewDidChangeHeight(textView)
        }

        public func resizableTextViewShouldBeginEditing(_ textView: ResizableTextView) -> Bool {
            return delegate?.resizableTextViewShouldBeginEditing(textView) ?? true
        }

        public func resizableTextView(_ textView: ResizableTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return delegate?.resizableTextView(textView, shouldChangeTextIn: range, replacementText: text) ?? true
        }
    }

    public extension TextArea {
        public final class State: Equatable {
            public static func == (lhs: TextArea.State, rhs: TextArea.State) -> Bool {
                return lhs.placeholder == rhs.placeholder
                    && lhs.value == rhs.value
                    && lhs.error == rhs.error
                    && lhs.error == rhs.title
                    && lhs.focused == rhs.focused
                    && lhs.status == rhs.status
                    && lhs.maxLength == rhs.maxLength
                    && lhs.height == rhs.height
            }

            public var placeholder: String?
            public var value: String?
            public var error: String? {
                didSet {
                    if (error ?? "").isEmpty == false {
                        status = .error
                    } else {
                        status = .none
                    }
                }
            }

            public var title: String?
            public var focused = false
            public var status: Status = .none
            public var maxLength: Int

            public static let defaultHeight: CGFloat = 32
            public static let defaultMaxLength = 70

            var height = defaultHeight

            public init(
                placeholder: String? = nil,
                value: String? = nil,
                error: String? = nil,
                title: String? = nil,
                focused: Bool = false,
                status: Status = .none,
                maxLength: Int = TextArea.State.defaultMaxLength
            ) {
                self.placeholder = placeholder
                self.value = value
                self.focused = focused
                self.title = title
                self.status = status
                self.maxLength = maxLength
                self.error = error
            }
        }

        enum Status {
            case none
            case error
            case disabled
            case valid
        }
    }
#endif
