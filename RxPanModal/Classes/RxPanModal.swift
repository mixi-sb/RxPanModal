
import RxCocoa
import RxSwift

public protocol RxPanModalItem {
    static var controllerType: RxPanModalPresentable.Type { get }
}

public struct RxPanModal {
    
    private let item: RxPanModalItem
    
    var viewController: RxPanModalPresentable? {
        return type(of: item).controllerType.create(item: item)
    }
    
    public init(_ item: RxPanModalItem) {
        self.item = item
    }
    
}

extension ObserverType where Element == RxPanModal {
    
    public func onNext(item: RxPanModalItem) {
        onNext(RxPanModal(item))
    }
    
}
