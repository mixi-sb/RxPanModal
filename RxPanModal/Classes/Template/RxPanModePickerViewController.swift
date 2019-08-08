//
//  RxPanModalPickerViewController.swift
//  RxPanModal
//
//  Created by Meng Li on 2019/08/07.
//  Copyright © 2018 XFLAG. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SnapKit
import PanModal

private enum Const {
    
    static let height: CGFloat = 291
    
    enum Drag {
        static let size = CGSize(width: 35, height: 6)
        static let marginTop = 6
    }
    
    enum Picker {
        static let marginTop = 15
    }
    
    enum Done {
        static let marginRight = 16
    }
    
}

public struct RxPanModalPickerItem: RxPanModalItem {
    
    public static let controllerType: RxPanModalPresentable.Type = RxPanModalPickerViewController.self
    
    public typealias DidSelectItem = (Int, CustomStringConvertible) -> Void
    
    public enum Theme {
        case dark
        case light
        case custom(
            backgroundColor: UIColor?,
            doneColor: UIColor?,
            titleColor: UIColor?,
            pickerTitleAttributes: [NSAttributedString.Key: Any]
        )
    }
    
    let theme: Theme
    let title: String
    let done: String
    let models: [CustomStringConvertible]
    let didSelectItemAt: DidSelectItem?
    let doneAt: DidSelectItem?
    
    public init(
        theme: Theme = .dark,
        title: String,
        done: String,
        models: [CustomStringConvertible],
        didSelectItemAt: DidSelectItem? = nil,
        doneAt: DidSelectItem? = nil
    ) {
        self.theme = theme
        self.title = title
        self.done = done
        self.models = models
        self.didSelectItemAt = didSelectItemAt
        self.doneAt = doneAt
    }
    
}

open class RxPanModalPickerViewController: UIViewController {

    private lazy var dragView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x5e5e5e)
        view.layer.cornerRadius = Const.Drag.size.height / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = item.theme.titleColor
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = item.title
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(item.done, for: .normal)
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
        button.setTitleColor(item.theme.doneColor, for: .normal)
        button.setTitleColor(item.theme.doneColor?.lighter(), for: .highlighted)
        return button
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private let item: RxPanModalPickerItem
    
    required public init(item: RxPanModalPickerItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = item.theme.backgroundColor
        view.addSubview(dragView)
        view.addSubview(titleLabel)
        view.addSubview(doneButton)
        view.addSubview(pickerView)
        createConstraints()
    }
    
    private func createConstraints() {
        
        dragView.snp.makeConstraints {
            $0.size.equalTo(Const.Drag.size)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(Const.Drag.marginTop)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dragView.snp.bottom)
            $0.bottom.equalTo(pickerView.snp.top)
        }
        
        doneButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview().offset(-Const.Done.marginRight)
        }
        
        pickerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func done() {
        dismiss(animated: true)
        let row = pickerView.selectedRow(inComponent: 0)
        if 0..<item.models.count ~= row {
            item.doneAt?(row, item.models[row])
        }
    }
    
}

extension RxPanModalPickerViewController: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return item.models.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: item.models[row].description, attributes: item.theme.pickerTitleAttributes)
    }
    
}

extension RxPanModalPickerViewController: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard 0..<item.models.count ~= row else {
            return
        }
        item.didSelectItemAt?(row, item.models[row])
    }
    
}

extension RxPanModalPickerViewController: RxPanModalPresentable {
    
    public static func create(item: RxPanModalItem) -> Self? {
        guard let item = item as? RxPanModalPickerItem else {
            return nil
        }
        return self.init(item: item)
    }
    
    public var panScrollable: UIScrollView? {
        return nil
    }
    
    public var longFormHeight: PanModalHeight {
        return .contentHeightIgnoringSafeArea(Const.height)
    }
    
    public var showDragIndicator: Bool {
        return false
    }
    
}

extension RxPanModalPickerItem.Theme {
    
    var backgroundColor: UIColor? {
        switch self {
        case .dark:
            return UIColor(hexa: 0x3b3b3bcc)
        case .light:
            return UIColor(hexa: 0xffffffcc)
        case .custom(let color, _, _, _):
            return color
        }
    }
    
    var doneColor: UIColor? {
        switch self {
        case .dark:
            return UIColor(hex: 0x0091d4)
        case .light:
            return UIColor(hex: 0x367bf7)
        case .custom(_, let color, _, _):
            return color
        }
    }
    
    var titleColor: UIColor? {
        switch self {
        case .dark:
            return .white
        case .light:
            return .darkText
        case .custom(_, _, let color, _):
            return color
        }
    }
    
    var pickerTitleAttributes: [NSAttributedString.Key: Any] {
        switch self {
        case .dark:
            return [
                .foregroundColor: UIColor.white
            ]
        case .light:
            return [
                .foregroundColor: UIColor.darkText
            ]
        case .custom(_, _, _, let attributes):
            return attributes
        }
    }
    
}
