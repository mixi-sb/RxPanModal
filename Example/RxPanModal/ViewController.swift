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
    
    private lazy var backgrounImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "background.jpg")
        return imageView
    }()
    
    private lazy var modalButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open Modal", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.rx.tap.bind { [unowned self] in
            self.viewModel.openModal()
        }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var nameLabel = UILabel()

    private lazy var pickerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open Picker", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.rx.tap.bind { [unowned self] in
            self.viewModel.openPicker()
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
        view.addSubview(backgrounImageView)
        view.addSubview(modalButton)
        view.addSubview(nameLabel)
        view.addSubview(pickerButton)
        createConstraints()
        
        viewModel.panModal.bind(to: rx.panModal).disposed(by: disposeBag)
        viewModel.name.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
    }
    
    private func createConstraints() {
        
        backgrounImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        modalButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(80)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(modalButton.snp.bottom).offset(20)
        }
        
        pickerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        
    }

}
