//
//  ViewModel.swift
//  RxPanModal_Example
//
//  Created by Meng Li on 2019/08/06.
//  Copyright © 2019 XFLAG. All rights reserved.
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
    
    func openPicker() {
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
    }
    
}

