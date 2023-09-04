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
    private let scaleIndex : CGFloat = 0.75
    private let textInsetSpace : CGFloat = 1.5
    private let placeholderAlphaAfter : CGFloat = 0.85
    private let placeholderAlphaBefore : CGFloat = 0.5

    private var placeholderLabelView: UILabel
    private var bottomlineView: UIView
    private var isMoveUp = false
    private var isChanged  = false
    open var placeholderFont: UIFont?

    @IBInspectable var bottomLineWidth : CGFloat = 1.0
    @IBInspectable var bottomLineColor : UIColor = .black
    @IBInspectable var bottomLineAlphaBefore : CGFloat = 0.5
    @IBInspectable var bottomLineAlphaAfter : CGFloat = 1
    @IBInspectable var placeholderTextColor : UIColor = .gray
    @IBInspectable var animateDuration : TimeInterval = 0.35

    public init(bottomLineWidth: CGFloat = 2.0,
                bottomLineColor: UIColor = .black,
                bottomLineAlphaBefore: CGFloat = 0.5,
                bottomLineAlphaAfter: CGFloat = 1,
                placeholderTextColor: UIColor = .gray,
                animateDuration: TimeInterval = 0.35) {
        self.placeholderLabelView = UILabel(frame: .zero)
        self.bottomlineView = UIView(frame: .zero)
        self.bottomLineWidth = bottomLineWidth
        self.bottomLineColor = bottomLineColor
        self.bottomLineAlphaBefore = bottomLineAlphaBefore
        self.bottomLineAlphaAfter = bottomLineAlphaAfter
        self.placeholderTextColor = placeholderTextColor
        self.animateDuration = animateDuration
        super.init(frame: .zero)
    }

    required public init?(coder: NSCoder) {
        self.placeholderLabelView = UILabel(frame: .zero)
        self.bottomlineView = UIView(frame: .zero)
        super.init(coder: coder)
    }
    
    open func setPlaceholder( _ text: String) {
        self.placeholder = text
    }

    open func setText(_ text: String) {
        self.text = text
    }

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawLine()
        NotificationCenter.default.addObserver(self, selector: #selector(didBeginTextEdit), name: UITextField.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(didTextDidChange), name: UITextField.textDidChangeNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(didEndTextEdit), name: UITextField.textDidEndEditingNotification, object: self)
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

        if let placeholderFont = placeholderFont {
            placeholderLabelView.font = placeholderFont
        } else {
            placeholderLabelView.font = UIFont(name: font.fontName, size: font.pointSize)
        }

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
    fileprivate func moveUpAnimation() {
        UIView.animate(withDuration: animateDuration, animations: {
            self.isChanged = true
            self.placeholderLabelView.transform = CGAffineTransform(scaleX: self.scaleIndex, y: self.scaleIndex)
            self.placeholderLabelView.alpha = self.placeholderAlphaAfter
            self.placeholderLabelView.center = CGPoint(x: self.placeholderLabelView.center.x * self.scaleIndex, y: 0 + self.placeholderLabelView.frame.size.height)
            self.bottomlineView.alpha = self.bottomLineAlphaAfter
        }, completion: { (_) in
            self.isMoveUp = true
            self.isChanged = false
        })
    }

    @objc private func didBeginTextEdit() {
        if !self.isMoveUp {
            if self.isChanged {
                return
            }
            moveUpAnimation()
        } else {
            UIView.animate(withDuration: animateDuration, animations: {
                self.bottomlineView.alpha = self.bottomLineAlphaAfter
            })
        }
    }

    fileprivate func moveDownAnimation() {
        UIView.animate(withDuration: animateDuration, animations: {
            self.isChanged = true
            self.placeholderLabelView.alpha = self.placeholderAlphaBefore
            self.placeholderLabelView.center = CGPoint(x: self.placeholderLabelView.center.x / self.scaleIndex, y: self.frame.size.height - self.bottomlineView.frame.size.height - self.placeholderLabelView.frame.size.height / 2.0 - 2.0)
            self.placeholderLabelView.transform = CGAffineTransform.identity
            self.bottomlineView.alpha = self.bottomLineAlphaBefore
        }, completion: { (_) in
            self.isChanged = false
            self.isMoveUp = false
        })
    }

    @objc private func didTextDidChange() {
        if self.isMoveUp {
            if self.text?.count == 0 {
                if self.isChanged {
                    return
                }
                moveDownAnimation()
            }
        } else {
            if self.text?.count ?? 0 > 0  {
                if self.isChanged {
                    return
                }
                moveUpAnimation()
            } else {
                UIView.animate(withDuration: animateDuration, animations: {
                    self.bottomlineView.alpha = self.bottomLineAlphaBefore
                })
            }
        }
    }

    @objc private func didEndTextEdit() {
        if isMoveUp, self.text?.count == 0 {
            moveDownAnimation()
        }
    }

    // MARK: - Dealloc
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
