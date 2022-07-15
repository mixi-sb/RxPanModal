//
//  RxPanModalShowable.swift
//  RxPanModal
//
//  Created by Meng Li on 2019/08/06.
//  Copyright © 2018 XFLAG. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import PanModal
import RxCocoa
import RxSwift
import UIKit

public protocol RxPanModalShowable {
    
}

extension RxPanModalShowable where Self: UIViewController {
    
    public func showPanModal(_ panModal: RxPanModal) {
        guard let viewController = panModal.viewController else {
            return
        }
        RxPanModalManager.shared.addViewController(viewController)
        presentPanModal(viewController)
    }
    
    public func showCustomPanModal(_ panModal: RxPanModal) {
        guard let viewController = panModal.viewController else {
            return
        }
        RxPanModalManager.shared.addViewController(viewController)
        presentCustomPanModal(viewController)
    }
    
    private func presentCustomPanModal(_ viewControllerToPresent: PanModalPresentable.LayoutType, sourceView: UIView? = nil, sourceRect: CGRect = .zero) {

        viewControllerToPresent.modalPresentationStyle = .custom
        viewControllerToPresent.modalPresentationCapturesStatusBarAppearance = true
        viewControllerToPresent.transitioningDelegate = PanModalPresentationDelegate.default

        present(viewControllerToPresent, animated: true, completion: nil)
    }
}

extension Reactive where Base: UIViewController, Base: RxPanModalShowable {
    
    public var panModal: Binder<RxPanModal> {
        return Binder(base) { viewController, panModal in
            viewController.showPanModal(panModal)
        }
    }
    
    public var customPanModal: Binder<RxPanModal> {
        Binder(base) { viewController, panModal in
            viewController.showCustomPanModal(panModal)
        }
    }
}
