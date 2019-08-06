
import PanModal

public protocol RxPanModalShowable {
    
}

extension RxPanModalShowable where Self: UIViewController {
    
    public func showPanModal(_ modal: RxPanModal) {
        presentPanModal(modal.viewController)
    }
    
}
