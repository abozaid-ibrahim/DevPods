//
//  SnackBarViewModel.swift
//  DevComponents
//
//  Created by abuzeid on 22.12.20.
//
import Foundation
#if canImport(UIKit)

    public struct SnackBarViewModel {
        public private(set) var text: String
        public private(set) var icon: UIImage?

        public init(text: String, icon: UIImage? = nil) {
            self.text = text
            self.icon = icon
        }

        public init(isSaved: Bool, savedStateText: String, savedStateIcon: UIImage, unsavedStateText: String, unsavedStateIcon: UIImage) {
            self.init(
                text: isSaved ? savedStateText : unsavedStateText,
                icon: isSaved ? savedStateIcon : unsavedStateIcon
            )
        }
    }
#endif
