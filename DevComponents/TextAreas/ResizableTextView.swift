//
//  ResizableTextView.swift
//  UIComponents
//
//  Created by abuzeid on 22.12.20.
//
import UIKit

@objc public protocol ResizableTextViewDelegate: NSObjectProtocol {
    func resizableTextViewDidChangeHeight(_ textView: ResizableTextView)
    func resizableTextViewShouldBeginEditing(_ textView: ResizableTextView) -> Bool
    func resizableTextView(_ textView: ResizableTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool

    @objc optional func resizableTextViewDidBeginEditing(_ textView: ResizableTextView)
    @objc optional func resizableTextViewDidEndEditing(_ text: String)

    @objc optional func resizableTextViewDidChange(_ textView: ResizableTextView)
}

@objc public class ResizableTextView: UITextView {
    @objc public private(set) var currentHeight: CGFloat = -1
    @objc public var maxLength: Int = 0
    @objc public var trimWhiteSpaceWhenEndEditing: Bool = true

    @objc public var maxHeight: CGFloat = 0

    @objc public weak var resizableTextViewDelegate: ResizableTextViewDelegate?

    @objc public private(set) var isShowingPlaceholder: Bool = false {
        didSet {
            if isShowingPlaceholder {
                currentHeight = -1
            }
            placeholderLabel.isHidden = !isShowingPlaceholder
        }
    }

    @objc public private(set) var placeholder: NSAttributedString? {
        didSet {
            if let placeholder = placeholder {
                placeholderLabel.attributedText = placeholder
                isShowingPlaceholder = text.isEmpty
            }
        }
    }

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        addSubview(label)
        sendSubviewToBack(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        return label
    }()

    @objc public var visibleText: String {
        if isShowingPlaceholder {
            return ""
        }

        return text
    }

    private var _textColor: UIColor? = .charcoal
    private var _font: UIFont? = .systemFont(ofSize: 16)

    override public func awakeFromNib() {
        super.awakeFromNib()

        isScrollEnabled = false
        isPagingEnabled = false
        isMultipleTouchEnabled = false

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false

        textContainer.heightTracksTextView = false

        clipsToBounds = true

        delegate = self
    }

    @objc public func setup(text: String, textColor: UIColor? = .charcoal, placeholder: NSAttributedString? = nil) {
        self.text = text

        if maxLength > 0 {
            self.text = String(text.utf16.prefix(maxLength))
        }

        if maxHeight > 0 {
            isScrollEnabled = sizeThatFits(frame.size).height > maxHeight
            showsVerticalScrollIndicator = isScrollEnabled
        }

        self.textColor = textColor
        self._textColor = textColor
        self.placeholder = placeholder ?? self.placeholder

        isShowingPlaceholder = self.text.isEmpty
    }

    @objc public func update(text: String) {
        setup(text: text)
        textViewDidChange(self)
    }

    private func updateCalculatedHeight() -> Bool {
        guard !isShowingPlaceholder else {
            return false
        }

        let calculatedHeight = sizeThatFits(frame.size).height

        if currentHeight != calculatedHeight {
            currentHeight = calculatedHeight
            return true
        }

        return false
    }

    @objc public func refreshHeight() -> CGFloat {
        if updateCalculatedHeight() {
            if maxHeight > 0 {
                isScrollEnabled = sizeThatFits(frame.size).height > maxHeight
                showsVerticalScrollIndicator = isScrollEnabled
            }
        }

        return currentHeight
    }
}

extension ResizableTextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        if updateCalculatedHeight() {
            if maxHeight > 0 {
                isScrollEnabled = sizeThatFits(frame.size).height > maxHeight
                showsVerticalScrollIndicator = isScrollEnabled
            }

            resizableTextViewDelegate?.resizableTextViewDidChangeHeight(self)
        }

        resizableTextViewDelegate?.resizableTextViewDidChange?(self)
    }

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return resizableTextViewDelegate?.resizableTextViewShouldBeginEditing(textView as! ResizableTextView) ?? true
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        textViewDidChangeSelection(textView)

        resizableTextViewDelegate?.resizableTextViewDidBeginEditing?(self)
    }

    public func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.isFirstResponder, isShowingPlaceholder {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }

    private func resizableTextViewRequiresHeightCalculation() {
        resizableTextViewDelegate?.resizableTextViewDidChangeHeight(self)
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = isShowingPlaceholder ? "" : textView.text

        if maxLength > 0, currentText?.utf16.count == maxLength, !text.isEmpty {
            _ = resizableTextViewDelegate?.resizableTextView((textView as! ResizableTextView), shouldChangeTextIn: range, replacementText: text)
            return false
        }

        var updatedText = (currentText as NSString?)?.replacingCharacters(in: range, with: text)
        var isTextTruncated: Bool = false
        if updatedText != nil, maxLength > 0, updatedText!.utf16.count > maxLength {
            updatedText = updatedText!.utf16[0..<maxLength]
            isTextTruncated = true
        }

        if updatedText?.isEmpty ?? true {
            self.text = ""
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            isShowingPlaceholder = true

            resizableTextViewRequiresHeightCalculation()
        } else if isTextTruncated {
            isShowingPlaceholder = false
            self.text = updatedText
            resizableTextViewRequiresHeightCalculation()
            _ = resizableTextViewDelegate?.resizableTextView((textView as! ResizableTextView), shouldChangeTextIn: range, replacementText: text)
            return false
        } else if !text.isEmpty {
            isShowingPlaceholder = false
        }

        return resizableTextViewDelegate?.resizableTextView((textView as! ResizableTextView), shouldChangeTextIn: range, replacementText: text) ?? false
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if trimWhiteSpaceWhenEndEditing {
            text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        resizableTextViewDelegate?.resizableTextViewDidEndEditing?(isShowingPlaceholder ? "" : textView.text)
    }
}
