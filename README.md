# RxPanModal

[![Build Status](https://app.bitrise.io/app/b831d3c7c2819e78/status.svg?token=BEXIr7I68UsW_H5UHF2wgw)](https://app.bitrise.io/app/b831d3c7c2819e78)
[![Version](https://img.shields.io/cocoapods/v/RxPanModal.svg?style=flat)](https://cocoapods.org/pods/RxPanModal)
[![License](https://img.shields.io/cocoapods/l/RxPanModal.svg?style=flat)](https://cocoapods.org/pods/RxPanModal)
[![Platform](https://img.shields.io/cocoapods/p/RxPanModal.svg?style=flat)](https://cocoapods.org/pods/RxPanModal)

RxPanModal is a RxSwift reactive extension for the library PanModal. With RxPanModal, a view controller can be presented as a pan modal from the view model directly.

## Documentation

RxPanModal is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxPanModal'
```

### Present customized view controller as a pan modal

To present a view controller as a pan modal from a view model directly, the view controller should implement the procotol `RxPanModalPresentable`.

```swift
extension SelectorViewController: RxPanModalPresentable {
    
    static func create(item: RxPanModalItem) -> Self? {
        guard let item = item as? SelectorPanModalItem else {
            return nil
        }
        return self.init(item: item)
    }
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    
}
```

In the static method `create`, there is a struct `SelectorPanModalItem` which implements the protocol `RxPanModalItem`.

```swift
struct SelectorPanModalItem: RxPanModalItem {

    static let controllerType: RxPanModalPresentable.Type = SelectorViewController.self

    let names: [String]
    let didNameSelected: (String) -> Void
}
```

In the item struct, the controller type should be indicated.
Other properties and closures for exchanging data with view model should also be defined in the item struct.

After implementing the customized view modal, a `PublishSubject` property `panModal` should be prepared in the view model.

```swift
class ViewModel {
    private let panModalSubject = PublishSubject<RxPanModal>()
    
    var panModal: Observable<RxPanModal> {
        return panModalSubject.asObservable()
    }
}
```

The corresponding view controller should implement the protocol `RxPanModalShowable` and bind the observable `panModel`.

```swift
class ViewController: UIViewController, RxPanModalShowable {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.name.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
    }
}
```

At last, we can present the customized view controller from the view model directly.

```swift
panModalSubject.onNext(item: SelectorPanModalItem(names: ["Alice", "Bob", "Carol"]) { 
    print($0)
})
```

### Prepared template

To use the prepared template view controllers, just install with the subspec `RxPanModal/Template`.

```ruby
pod 'RxPanModal/Template'
```

The following templates in prepared.

- RxPanModalPickerViewController

```swift
panModalSubject.onNextPicker(
    theme: .dark,
    title: "Months",
    done: "Done",
    models: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Nov", "Dec"],
    didSelectItemAt: { index, model in
        print("select at \(index) " + model.description)
    },
    doneAt: { index, model in
        print("done at \(index) " + model.description)
    }
)
```

### Dissmiss all presented pan modals.

Sometimes, if you want to dismiss all presented pan modals, just invoke `RxPanModal.dismissAll()` from anywhere.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## License

RxPanModal is available under the MIT license. See the LICENSE file for more info.
