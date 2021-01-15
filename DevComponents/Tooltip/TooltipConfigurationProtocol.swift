//
//  TooltipConfigurationProtocol.swift
//  DevComponents
//
//  Created by abuzeid on 22.12.20.
//

import Foundation
#if canImport(UIKit)

    public protocol TooltipConfigurationProtocol {
        var titleAttributedString: NSAttributedString? { get }
        var subtitleAttributedString: NSAttributedString? { get }
    }
#endif
