//
//  TabBar.swift
//  Direct
//
//  Created by abuzeid on 5/17/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

public typealias TAB = (String, () -> Void?)

class TabBar: UIView {
    let stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        stack.semanticContentAttribute = .forceRightToLeft

        return stack
    }()

    func createContentStack() -> UIStackView {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }

    var selector: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true

        return view
    }

    var label: UILabel {
        let lbl = UILabel()

        return lbl
    }

    var icon: UIImageView {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "icons8More")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 15).isActive = true
        iv.contentMode = .scaleAspectFit
        return iv
    }

    private var tabsSep: [UIView] = []
    var tabsIcon: [UIImageView] = []

    func createUI(tabs: [TAB]) {
        for (index, tab) in tabs.enumerated() {
            let content = createContentStack()
            let lbl = UILabel()
            lbl.textAlignment = .center
            lbl.text = tab.0
            let iv = icon
            content.addArrangedSubview(iv)
            content.addArrangedSubview(lbl)
            let sel = selector
            let oneTabView = UIStackView(arrangedSubviews: [content, sel])
            oneTabView.alignment = .fill
            oneTabView.axis = .vertical
            oneTabView.spacing = 5
//            oneTabView.rx.tapGesture().asObservable().skip(1).subscribe { _ in
//                tab.1()
//                for (i, sep) in self.tabsSep.enumerated() {
//                    if index == i {
//                        sep.alpha = 1.0
//                    } else {
//                        sep.alpha = 0.0
//                    }
//                }
//
//            }.disposed(by: bag)
            tabsSep.append(sel)
            tabsIcon.append(iv)
            stackContainer.addArrangedSubview(oneTabView)
        }
        // set default selection 1
        setFirstDefaultSelector()
        addSubview(stackContainer)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: stackContainer.leadingAnchor, constant: CGFloat(8)),
            trailingAnchor.constraint(equalTo: stackContainer.trailingAnchor, constant: -CGFloat(8)),
            topAnchor.constraint(equalTo: stackContainer.topAnchor, constant: CGFloat(0)),
            bottomAnchor.constraint(equalTo: stackContainer.bottomAnchor, constant: -CGFloat(0))])
    }

    func didSelectTab(index: Int) {
        for (i, sep) in tabsSep.enumerated() {
            if index == i {
                sep.alpha = 1.0
            } else {
                sep.alpha = 0.0
            }
        }
    }

    private func setFirstDefaultSelector() {
        for sep in tabsSep.enumerated() {
            if sep.offset == 0 {
                sep.element.alpha = 1.0

            } else {
                sep.element.alpha = 0.0
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI(tabs: [])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createUI(tabs: [])
    }

    init(tabs: [TAB]) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 40)))
        createUI(tabs: tabs)
    }
}
