import PanModal

public protocol RxPanModalPresentable: UIViewController & PanModalPresentable {
    static func create() -> Self
}

