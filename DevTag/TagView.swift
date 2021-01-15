//
//  TagView.swift
//  DevTag
//
//  Created by abuzeid on 5/18/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

#if canImport(UIKit)

    enum TagViewAligment {
        case left, right
    }

    protocol TagsView {}
    public typealias TagDataModel = (String, UIImage?)
    @IBDesignable
    public class TagView: UIView, TagsView {
        var aligment: TagViewAligment = .right {
            didSet {
                switch aligment {
                case .left:
                    layout.horizontalAlignment = .left
                case .right:
                    layout.horizontalAlignment = .right
                }
            }
        }

        @IBInspectable
        public var font = UIFont.systemFont(ofSize: 10)

        @IBInspectable
        public var textColor: UIColor = .black

        @IBInspectable
        public var bgColor: UIColor = .white

        @IBInspectable
        public var inimumInteritemSpacing = 10

        @IBInspectable
        public var minimumLineSpacing = 10

        private let layout: AlignedCollectionViewFlowLayout = {
            let layout = AlignedCollectionViewFlowLayout()
            layout.horizontalAlignment = .leading
            layout.scrollDirection = .vertical
            if #available(iOS 10.0, *) {
                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            } else {
                layout.estimatedItemSize = CGSize(width: 100, height: 28)
            }
            layout.minimumInteritemSpacing = 6
            layout.minimumLineSpacing = 6
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

            return layout
        }()

        lazy var collectionView: UICollectionView = {
            let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
            collection.backgroundColor = .white
            return collection
        }()

        public var items: [TagDataModel] = []
        override init(frame: CGRect) {
            super.init(frame: frame)
        }

        init(tags _: [TagDataModel]) {
            super.init(frame: CGRect.zero)
            setup()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }

        func setup() {
            backgroundColor = .white
            layer.borderColor = UIColor.lightGray.cgColor
            addCollectionView()
            let bundle = Bundle(for: type(of: self))
            collectionView.register(UINib(nibName: TagCollectionCell.id, bundle: bundle), forCellWithReuseIdentifier: TagCollectionCell.id)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }

        private func addCollectionView() {
            addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        }
    }

    extension TagView: UICollectionViewDelegate {
        public func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {}
    }

    extension TagView: UICollectionViewDelegateFlowLayout {
        public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
            return CGSize.zero
        }

        public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let label = UILabel(frame: CGRect.zero)
            label.font = font
            label.text = items[indexPath.row].0
            let iconWidth = items[indexPath.row].1 == nil ? 8 : CGFloat(25)
            label.sizeToFit()
            let size = label.frame.size
            let padding = CGFloat(12)
            return CGSize(width: size.width + iconWidth + padding, height: 30)
        }
    }

    extension TagView: UICollectionViewDataSource {
        public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
            return items.count
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionCell.id, for: indexPath) as! TagCollectionCell
            cell.setCellModel(model: items[indexPath.row])
            cell.setFont(font, bgColor: bgColor, txtColor: textColor)
            return cell
        }
    }
#endif
