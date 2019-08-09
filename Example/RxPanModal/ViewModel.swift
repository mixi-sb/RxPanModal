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
    
    private let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Nov", "Dec"]
    
    private let panModalSubject = PublishSubject<RxPanModal>()
    private let nameSubject = PublishSubject<String?>()
    private let monthRelay = BehaviorRelay<Int>(value: 0)
    
    var panModal: Observable<RxPanModal> {
        return panModalSubject.asObservable()
    }
    
    var name: Observable<String?> {
        return nameSubject.asObservable()
    }
    
    var month: Observable<String?> {
        return monthRelay.map {
            "Open Picker: " + self.months[$0]
        }
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
            models: months,
            selectAt: monthRelay.value,
            didSelectItemAt: { index, model in
                print("select at \(index) " + model.description)
            },
            doneAt: { [unowned self] index, model in
                self.monthRelay.accept(index)
            }
        )
    }
    
}

