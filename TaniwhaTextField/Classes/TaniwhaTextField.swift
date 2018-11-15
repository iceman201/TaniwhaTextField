// The MIT License (MIT)

// Copyright (c) 2017 Liguo Jiao
// https://liguo.jiao.co.nz
// email: liguo@jiao.co.nz


// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

@IBDesignable open class TaniwhaTextField: UITextField {
    let scaleIndex : CGFloat = 0.75
    let textInsetSpace : CGFloat = 1.5
    let placeholderAlphaAfter : CGFloat = 0.85
    let placeholderAlphaBefore : CGFloat = 0.5

    var placeholderLabelView = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var bottomlineView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var isMoveUp = false
    var isChanged  = false

    @IBInspectable var bottomLineWidth : CGFloat = 2.0
    @IBInspectable var bottomLineColor : UIColor = .black
    @IBInspectable var bottomLineAlphaBefore : CGFloat = 0.5
    @IBInspectable var bottomLineAlphaAfter : CGFloat = 1
    @IBInspectable var placeholderTextColor : UIColor = .gray
    @IBInspectable var animateDuration : TimeInterval = 0.35

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawLine()
        NotificationCenter.default.addObserver(self, selector: #selector(didBeginTextEdit), name: UITextField.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(didTextEditFinish), name: UITextField.textDidChangeNotification, object: self)
    }

    override open func drawPlaceholder(in rect: CGRect) {
        super.drawPlaceholder(in: rect)
        guard let font = self.font else {
            return
        }

        placeholderLabelView = UILabel(frame: CGRect(x: rect.origin.x, y: bottomLineWidth, width: rect.size.width, height: font.pointSize))
        placeholderLabelView.center = CGPoint(x: placeholderLabelView.center.x, y: frame.size.height - bottomlineView.frame.size.height - placeholderLabelView.frame.size.height / 2)
        placeholderLabelView.text = self.placeholder
        self.placeholder = nil

        placeholderLabelView.font = UIFont(name: font.fontName, size: font.pointSize)
        placeholderLabelView.textColor = placeholderTextColor
        placeholderLabelView.alpha = placeholderAlphaBefore

        self.addSubview(placeholderLabelView)
        self.bringSubviewToFront(placeholderLabelView)
    }

    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect)

        if self.placeholder != nil {
            drawPlaceholderAfterTransshaped(rect: rect)
        }
        self.textAlignment = .left
        self.contentVerticalAlignment = .bottom
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let insetSpaceY = self.bottomLineWidth + 2.0
        self.textAlignment = .left
        self.contentVerticalAlignment = .bottom
        return bounds.insetBy(dx: self.textInsetSpace, dy: insetSpaceY)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insetSpaceY = self.bottomLineWidth + 2.0
        self.textAlignment = .left
        self.contentVerticalAlignment = .bottom
        return bounds.insetBy(dx: self.textInsetSpace, dy: insetSpaceY)
    }

    fileprivate func drawLine() {
        let bottomLine = UIView(frame:CGRect(x: 0, y: frame.size.height - bottomLineWidth, width: frame.size.width, height: bottomLineWidth))
        bottomLine.backgroundColor = bottomLineColor
        bottomLine.alpha = bottomLineAlphaBefore
        bottomlineView = bottomLine
        self.addSubview(bottomlineView)
    }

    fileprivate func drawPlaceholderAfterTransshaped(rect: CGRect) {
        guard let font = self.font else {
            return
        }
        placeholderLabelView = UILabel(frame: CGRect(x: rect.origin.x, y: bottomLineWidth * 2, width: rect.size.width, height: font.pointSize))
        placeholderLabelView.transform = CGAffineTransform(scaleX: scaleIndex, y: scaleIndex)
        placeholderLabelView.center = CGPoint(x: placeholderLabelView.center.x * scaleIndex, y: 0 + placeholderLabelView.frame.size.height)
        placeholderLabelView.text = self.placeholder
        self.placeholder = nil

        placeholderLabelView.font = UIFont(name: font.fontName, size: font.pointSize)
        placeholderLabelView.textColor = placeholderTextColor
        placeholderLabelView.alpha = placeholderAlphaAfter
        isMoveUp = true

        self.addSubview(placeholderLabelView)
        self.bringSubviewToFront(placeholderLabelView)
    }

    // MARK: - Delegate
    @objc private func didBeginTextEdit() {
        if !self.isMoveUp {
            if self.isChanged {
                return
            }
            UIView.animate(withDuration: animateDuration, animations: {
                self.isChanged = true
                self.placeholderLabelView.transform = CGAffineTransform(scaleX: self.scaleIndex, y: self.scaleIndex)
                self.placeholderLabelView.alpha = self.placeholderAlphaAfter
                self.placeholderLabelView.center = CGPoint(x: self.placeholderLabelView.center.x * self.scaleIndex, y: 0 + self.placeholderLabelView.frame.size.height)
                self.bottomlineView.alpha = self.bottomLineAlphaAfter
            }, completion: { (done) in
                if done {
                    self.isMoveUp = true
                    self.isChanged = false
                }
            })
        } else {
            UIView.animate(withDuration: animateDuration, animations: {
                self.bottomlineView.alpha = self.bottomLineAlphaAfter
            })
        }
    }

    @objc private func didTextEditFinish() {
        if self.isMoveUp {
            if self.text?.count == 0 {
                if self.isChanged {
                    return
                }
                UIView.animate(withDuration: animateDuration, animations: {
                    self.isChanged = true
                    self.placeholderLabelView.alpha = self.placeholderAlphaBefore
                    self.placeholderLabelView.center = CGPoint(x: self.placeholderLabelView.center.x / self.scaleIndex, y: self.frame.size.height - self.bottomlineView.frame.size.height - self.placeholderLabelView.frame.size.height / 2.0 - 2.0)
                    self.placeholderLabelView.transform = CGAffineTransform.identity
                    self.bottomlineView.alpha = self.bottomLineAlphaBefore
                }, completion: { (done) in
                    if done {
                        self.isChanged = false
                        self.isMoveUp = false
                    }
                })
            }
        } else {
            if (self.text?.count)! > 0  {
                if self.isChanged {
                    return
                }
                UIView.animate(withDuration: animateDuration, animations: {
                    self.isChanged = true
                    self.placeholderLabelView.transform = CGAffineTransform(scaleX: self.scaleIndex, y: self.scaleIndex)
                    self.placeholderLabelView.alpha = self.placeholderAlphaAfter
                    self.placeholderLabelView.center = CGPoint(x: self.placeholderLabelView.center.x * self.scaleIndex, y: 0 + self.placeholderLabelView.frame.size.height)
                    self.bottomlineView.alpha = self.bottomLineAlphaAfter
                }, completion: { (done) in
                    if done {
                        self.isMoveUp = true
                        self.isChanged = false
                    }
                })
            } else {
                UIView.animate(withDuration: animateDuration, animations: {
                    self.bottomlineView.alpha = self.bottomLineAlphaBefore
                })
            }
        }
    }

    // MARK: - Dealloc
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
