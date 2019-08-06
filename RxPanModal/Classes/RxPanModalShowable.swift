
import PanModal
import RxCocoa
import RxSwift

public protocol RxPanModalShowable {
    
}

extension RxPanModalShowable where Self: UIViewController {
    
    public func showPanModal(_ panModal: RxPanModal) {
        guard let viewController = panModal.viewController else {
            return
        }
        presentPanModal(viewController)
    }
    
}

extension Reactive where Base: UIViewController, Base: RxPanModalShowable {
    
    public var panModal: Binder<RxPanModal> {
        return Binder(base) { viewController, panModal in
            viewController.showPanModal(panModal)
        }
    }
    
}
