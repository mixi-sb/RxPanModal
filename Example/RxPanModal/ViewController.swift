//
//  ViewController.swift
//  RxPanModal
//
//  Created by Meng Li on 08/02/2019.
//  Copyright (c) 2019 XFLAG. All rights reserved.
//

import RxPanModal
import RxSwift
import SnapKit
import UIKit

class ViewController: UIViewController, RxPanModalShowable {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Open Modal", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.rx.tap.bind { [unowned self] in
            self.viewModel.openModal()
        }.disposed(by: disposeBag)
        return button
    }()

    private let disposeBag = DisposeBag()
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        createConstraints()
        
        viewModel.panModal.bind(to: rx.panModal).disposed(by: disposeBag)
    }
    
    private func createConstraints() {
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
