
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
    
    let title: String
    let done: String
    let models: [CustomStringConvertible]
    let didSelectItemAt: DidSelectItem?
    let doneAt: DidSelectItem?
    
    public init(
        title: String,
        done: String,
        models: [CustomStringConvertible],
        didSelectItemAt: DidSelectItem? = nil,
        doneAt: DidSelectItem? = nil
    ) {
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
        view.backgroundColor = UIColor(white: 94.0 / 255.0, alpha: 1)
        view.layer.cornerRadius = Const.Drag.size.height / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UIView = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = item.title
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(item.done, for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 145.0 / 255.0, blue: 212.0 / 255.0, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
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
        
        view.backgroundColor = UIColor(white: 59.0 / 255.0, alpha: 0.8)
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
        return NSAttributedString(string: item.models[row].description, attributes: [
            .foregroundColor: UIColor.white
        ])
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

