
import SnapKit
import PanModal

private enum Const {
    
    enum Drag {
        static let size = CGSize(width: 35, height: 6)
        static let marginTop = 6
    }
    
    enum Picker {
        static let marginTop = 15
    }
    
}

public struct RxPanModalPickerItem: RxPanModalItem {
    
    public static let controllerType: RxPanModalPresentable.Type = RxPanModalPickerViewController.self
    
    public init() {}
    
}

open class RxPanModalPickerViewController: UIViewController {

    let months = ["Jan", "Feb", "Mar", "Apr", "May"]
    
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
        label.text = "Months"
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Finish", for: .normal)
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
    
    required public init() {
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
            $0.right.equalToSuperview().offset(-16)
        }
        
        pickerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func done() {
        dismiss(animated: true)
    }
    
}

extension RxPanModalPickerViewController: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return months.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: months[row], attributes: [
            .foregroundColor: UIColor.white
        ])
    }
    
}

extension RxPanModalPickerViewController: UIPickerViewDelegate {
    
}

extension RxPanModalPickerViewController: RxPanModalPresentable {
    
    public static func create(item: RxPanModalItem) -> Self? {
        return self.init()
    }
    
    public var panScrollable: UIScrollView? {
        return nil
    }
    
    public var longFormHeight: PanModalHeight {
        return .contentHeightIgnoringSafeArea(291)
    }
    
    public var showDragIndicator: Bool {
        return false
    }
    
}

