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
    private let nameSubject = PublishSubject<String?>()
    
    var panModal: Observable<RxPanModal> {
        return panModalSubject.asObservable()
    }
    
    var name: Observable<String?> {
        return nameSubject.asObservable()
    }
    
    func openModal() {
        panModalSubject.onNext(item: SelectorPanModalItem(names: ["Alice", "Bob", "Carol"]) { [unowned self] in
            self.nameSubject.onNext($0)
        })
    }
    
}

