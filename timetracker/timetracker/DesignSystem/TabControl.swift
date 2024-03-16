//
//  TabControl.swift
//  timetracker
//
//  Created by Polina Egorova on 13.03.2024.
//

import UIKit

open class TabControl: UIScrollView {
    
    // MARK: Public Fields

    public var items: [String] {
        didSet { regenerateTabs() }
    }

    public var selectedIndex: Int {
        get { _selectedIndex }
        set {
            setSelectedIndex(to: newValue, animated: true)
        }
    }

    public func setSelectedIndex(to index: Int, animated: Bool) {
        _selectedIndex = index
        updateSelectionView(animated: animated)
        updateAccessibilityValue()
    }

    public var onTap: ((Int) -> Void)?

    public override var intrinsicContentSize: CGSize {
        intrinsicSize ?? .zero
    }

    // MARK: Accessibility

    public override func accessibilityIncrement() {
        setSelectedIndex(to: (selectedIndex + 1) % items.count, animated: false)
        onTap?(selectedIndex)
    }

    public override func accessibilityDecrement() {
        setSelectedIndex(to: (selectedIndex - 1 + items.count) % items.count, animated: false)
        onTap?(selectedIndex)
    }

    // MARK: UI Components

    private var labels: [UILabel] = []

    private var labelFrames: [CGRect] = []

    private var selectionFrames: [CGRect] = []

    private var selectionView: UIView

    private var intrinsicSize: CGSize?

    private var _selectedIndex: Int

    // MARK: Initialization

    public required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) is not implemented")
    }

    public init(items: [String] = [], selectedIndex: Int = -1, frame: CGRect = .zero) {
        self.items = items
        _selectedIndex = selectedIndex
        selectionView = UIView()
        selectionView.backgroundColor = .gray
        selectionView.isUserInteractionEnabled = false
        super.init(frame: frame)

        isAccessibilityElement = true
        accessibilityTraits = .adjustable

        setUpUI()
    }

    private func setUpUI() {
        setUpSelectionView()
        regenerateTabs()
        setUpTouchRecognizer()
        showsHorizontalScrollIndicator = false
        bounces = false
    }

    private func setUpSelectionView() {
        addSubview(selectionView)
    }

    private func regenerateTabs() {
        clearTabs()
        createTabs()
        positionTabs()
        updateSelectionView(animated: false)
        updateAccessibilityValue()
    }

    private func clearTabs() {
        labels.forEach { $0.removeFromSuperview() }
        labels = []
        labelFrames = []
        selectionFrames = []
        selectionView.isHidden = true
    }

    private func createTabs() {
        for item in items {
            let label = UILabel()
            label.text = item
            label.isUserInteractionEnabled = false
            addSubview(label)
            labels.append(label)
        }
    }

    private func positionTabs() {
        let barHeight = 32.0
        var maxWidth: CGFloat = 0
        var prevFrame: CGRect?

        labelFrames = []
        selectionFrames = []

        for label in labels {
            let left: CGFloat
            if let prevFrame = prevFrame {
                left = prevFrame.maxX + 24
            } else {
                left = 12
            }
            let frame = CGRect(
                x: left,
                y: CGFloat((barHeight - 15)) / 2.0,
                width: 30,
                height: 15
            )
            prevFrame = frame
            label.frame = frame
            maxWidth = frame.maxX

            labelFrames.append(frame)
            selectionFrames.append(frame.expanding(by: 12, maxHeight: barHeight))
        }

        let contentWidth = maxWidth + 12
        contentSize = CGSize(width: contentWidth, height: barHeight)
        intrinsicSize = contentSize
        invalidateIntrinsicContentSize()
    }

    private func updateSelectionView(animated: Bool) {
        guard selectedIndex < items.count else {
            selectedIndex = items.count - 1
            return
        }

        if selectedIndex < 0 {
            selectionView.isHidden = true
            return
        }
        for i in 0..<labels.count {
            labels[i].backgroundColor = i == selectedIndex ? .darkGray : .gray
        }
        let wasHidden = selectionView.isHidden
        selectionView.isHidden = false
        let frame = selectionFrames[selectedIndex]
        let cornerRadius = min(frame.height, frame.width) / 2.0
        if !bounds.contains(frame) && frame != selectionView.frame {
            scrollRectToVisible(frame, animated: animated && !wasHidden)
        }
        if animated && !wasHidden {
            UIView.animate(withDuration: 0.5) {
                self.selectionView.frame = frame
                self.selectionView.layer.cornerRadius = cornerRadius
            }
        } else {
            selectionView.frame = frame
            selectionView.layer.cornerRadius = cornerRadius
        }
    }

    private func updateAccessibilityValue() {
        guard selectedIndex >= 0 && selectedIndex < items.count else {
            accessibilityValue = nil
            return
        }

        accessibilityValue = items[selectedIndex]
    }

    func updateAppearance() {
        positionTabs()
        updateSelectionView(animated: false)
    }

    private func setUpTouchRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(processTap(_:)))
        addGestureRecognizer(tap)
    }

    @objc private func processTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        for (index, frame) in selectionFrames.enumerated() {
            if frame.contains(location) {
                onTap?(index)
                return
            }
        }
    }
}

private extension CGRect {
    func expanding(by value: CGFloat, maxHeight: CGFloat) -> CGRect {
        let hValue = value
        let vValue = min(value, (maxHeight - height) / 2.0)
        return CGRect(
            x: origin.x - hValue,
            y: origin.y - vValue,
            width: width + 2 * hValue,
            height: height + 2 * vValue
        )
    }
}

//extension UILabel {
//    public static func size(
//        text: String? = nil,
//        lineHeight: CGFloat = 8,
//        desiredWidth: CGFloat
//    ) -> CGSize {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = lineHeight.multiplier()
//        let attrString = NSAttributedString(
//            string: text ?? "",
//            attributes: [.paragraphStyle: paragraphStyle]
//        )
//        let size = attrString.boundingRect(withLimitedWidth: desiredWidth).size
//        return size
//    }
//}
