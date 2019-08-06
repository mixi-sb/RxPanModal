//
//  ViewController.swift
//  RxPanModal
//
//  Created by Meng Li on 08/02/2019.
//  Copyright (c) 2019 XFLAG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    }

}
