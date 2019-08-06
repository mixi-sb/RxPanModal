//
//  ViewModel.swift
//  RxPanModal_Example
//
//  Created by Meng Li on 2019/08/06.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import RxCocoa
import RxPanModal
import RxSwift

class ViewModel {
    
    private let panModalSubject = PublishSubject<RxPanModal>()
    
    var panModal: Observable<RxPanModal> {
        return panModalSubject.asObservable()
    }
    
    func openModal() {
        panModalSubject.onNext(RxPanModal(SelectorPanModalItem(names: ["Alice", "Bob", "Carol"])))
    }
    
}
