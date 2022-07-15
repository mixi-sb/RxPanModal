//
//  RxPanModal.swift
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

public protocol RxPanModalItem {
    static var controllerType: RxPanModalPresentable.Type { get }
}

public struct RxPanModal {
    
    private let item: RxPanModalItem

    var viewController: RxPanModalPresentable? {
        return type(of: item).controllerType.create(item: item)
    }

    public init(_ item: RxPanModalItem) {
        self.item = item
    }

    public static func dismissAll(animated: Bool = false) {
        RxPanModalManager.shared.dissmissAll(animated: animated)
    }
    
}
