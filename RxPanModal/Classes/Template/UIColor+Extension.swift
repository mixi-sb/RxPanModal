//
//  UIColor+Extension.swift
//  RxPanModal
//
//  Created by Meng Li on 2019/08/08.
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

extension UIColor {
    
    @objc
    convenience init(hex: UInt32) {
        let mask = 0x0000ff
        
        let r = CGFloat(Int(hex >> 16) & mask) / 255
        let g = CGFloat(Int(hex >> 8) & mask) / 255
        let b = CGFloat(Int(hex) & mask) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    @objc
    convenience init(hex: UInt32, alpha: CGFloat) {
        let mask = 0x0000ff
        
        let r = CGFloat(Int(hex >> 16) & mask) / 255
        let g = CGFloat(Int(hex >> 8) & mask) / 255
        let b = CGFloat(Int(hex) & mask) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    @objc
    convenience init(hexa: UInt32) {
        let mask = 0x000000FF
        
        let r = CGFloat(Int(hexa >> 24) & mask) / 255
        let g = CGFloat(Int(hexa >> 16) & mask) / 255
        let b = CGFloat(Int(hexa >> 8) & mask) / 255
        let a = CGFloat(Int(hexa) & mask) / 255
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    func lighter(by percentage: CGFloat = 20.0) -> UIColor? {
        return adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 20.0) -> UIColor? {
        return adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 20.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        return UIColor(
            red: min(red + percentage / 100, 1.0),
            green: min(green + percentage / 100, 1.0),
            blue: min(blue + percentage / 100, 1.0),
            alpha: alpha
        )
    }
    
    func highlightedColor(_ isHighlighted: Bool) -> UIColor? {
        return isHighlighted ? lighter() : self
    }
    
}
