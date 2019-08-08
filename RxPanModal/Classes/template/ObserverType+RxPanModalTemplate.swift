//
//  ObserverType+RxPanModalTemplate.swift
//  PanModal
//
//  Created by Meng Li on 2019/08/08.
//

import RxSwift

extension ObserverType where Element == RxPanModal {
    
    public func onNextPicker(
        title: String,
        done: String,
        models: [CustomStringConvertible],
        didSelectItemAt: RxPanModalPickerItem.DidSelectItem? = nil,
        doneAt: RxPanModalPickerItem.DidSelectItem? = nil
    ) {
        onNext(item: RxPanModalPickerItem(
            title: title,
            done: done,
            models: models,
            didSelectItemAt: didSelectItemAt,
            doneAt: doneAt
        ))
    }
    
}
