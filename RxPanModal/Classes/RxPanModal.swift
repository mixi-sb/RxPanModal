
public protocol RxPanModalItem {
    static var controllerType: RxPanModalPresentable.Type { get }
}

public struct RxPanModal {
    
    private let item: RxPanModalItem
    
    var viewController: RxPanModalPresentable {
        return type(of: item).controllerType.create()
    }
    
}
