//
//  BFEnhancedNumberField.swift
//  BFControlTestBed
//
//  Created by Christian Andersen on 1/12/2024.
//

import UIKit

class BFEnhancedNumberField: UIControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    enum EnhancedNumericTouchPlacement {
    case none,
        left,
        right
    }
    
    required override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        convenience init()
        {
            self.init()
            setUp()
        }
        
        
        private let _backingView : UIView = UIView()
        private let _editor : BFNumericField = BFNumericField(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        private let _leftWingletImage : UIImageView = UIImageView()
        private let _rightWingletImage : UIImageView = UIImageView()
    
        
        private var _editorLeftConstraint : NSLayoutConstraint = NSLayoutConstraint()
        private var _editorRightConstraint : NSLayoutConstraint = NSLayoutConstraint()
        private var _leftImageWidthConstraint : NSLayoutConstraint = NSLayoutConstraint()
        private var _rightImageWidthConstraint : NSLayoutConstraint = NSLayoutConstraint()
    
        private var _touchPlacement : EnhancedNumericTouchPlacement = .none
    
        private func setUp()
        {
//            backgroundColor = .yellow
//            //  add the numeric editor
            _backingView.translatesAutoresizingMaskIntoConstraints = false;
            _backingView.clipsToBounds = true
            _editor.translatesAutoresizingMaskIntoConstraints = false;
            _leftWingletImage.translatesAutoresizingMaskIntoConstraints = false
            _rightWingletImage.translatesAutoresizingMaskIntoConstraints = false
            _leftWingletImage.contentMode = .center
            _rightWingletImage.contentMode = .center
            addSubview(_backingView)
            addSubview(_leftWingletImage)
            addSubview(_rightWingletImage)
            addSubview(_editor)
            
            _backingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            _backingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            _backingView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            _backingView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            _editor.topAnchor.constraint(equalTo: _backingView.topAnchor).isActive = true;
            _editor.bottomAnchor.constraint(equalTo: _backingView.bottomAnchor).isActive = true;
            _editorLeftConstraint =  _editor.leftAnchor.constraint(equalTo: _backingView.leftAnchor , constant: _wingletWidth)
            _editorRightConstraint = _editor.rightAnchor.constraint(equalTo: _backingView.rightAnchor, constant: 0.0 - _wingletWidth)
            _editorLeftConstraint.isActive = true
            _editorRightConstraint.isActive = true
            _leftWingletImage.topAnchor.constraint(equalTo: _backingView.topAnchor).isActive = true
            _leftWingletImage.bottomAnchor.constraint(equalTo: _backingView.bottomAnchor).isActive = true
            _rightWingletImage.topAnchor.constraint(equalTo: _backingView.topAnchor).isActive = true
            _rightWingletImage.bottomAnchor.constraint(equalTo: _backingView.bottomAnchor).isActive = true
            _leftImageWidthConstraint = _leftWingletImage.widthAnchor.constraint(equalToConstant: _wingletWidth)
            _rightImageWidthConstraint = _rightWingletImage.widthAnchor.constraint(equalToConstant: _wingletWidth)
            _leftImageWidthConstraint.isActive = true
            _rightImageWidthConstraint.isActive = true
            _leftWingletImage.leftAnchor.constraint(equalTo: _backingView.leftAnchor).isActive = true
            _rightWingletImage.rightAnchor.constraint(equalTo: _backingView.rightAnchor).isActive = true

            _backingView.layer.cornerRadius = 4.0
            
            backgroundColor = .clear
            setIconography()
//            _backingView.backgroundColor = self.tintColor
//           //  _editor.backgroundColor = self.backgroundColor
        }
    
        private func leftWingletPressed()
        {
            let xxx = 1
        }
    
        private func rightWingletPressed()
        {
            let xxx = 1
        }
    
//        override var tintColor: UIColor!
//        {
//            get
//            {
//                return super.tintColor
//            }
//            set(newValue)
//            {
//                super.tintColor = newValue
//                _backingView.backgroundColor = newValue
//            }
//        }
//        
//    override var backgroundColor: UIColor?
//        {
//            get
//            {
//                return _editor.backgroundColor
//            }
//            set(newValue)
//            {
//                _editor.backgroundColor = newValue
//            }
//        }
        
   
    @IBInspectable public var editorBackgroundColor : UIColor?
    {
        get
        {
            return _editor.backgroundColor
        }
        set(newValue)
        {
            _editor.backgroundColor = newValue
        }
    }
    
    @IBInspectable public var wingletsBackgroundColor : UIColor?
    {
        get
        {
            return _backingView.backgroundColor
        }
        set(newValue)
        {
            _backingView.backgroundColor = newValue
        }
    }
    
    @IBInspectable public var textColor: UIColor?
        {
            get
            {
                return _editor.textColor
            }
            set(newValue)
            {
                _editor.textColor = newValue
            }
        }
        
        
    @IBInspectable public var delegate : UITextFieldDelegate?
        {
            get
            {
                return _editor.delegate
            }
            set(newValue)
            {
                _editor.delegate = newValue
            }
        }
    
    @IBInspectable public var wingletWidth : Float = 20.0
    {
        didSet
        {
            UpdateWingletConstraints()
        }
    }

    @IBInspectable public var windletsVisible: Bool = true
    {
        didSet
        {
            UpdateWingletConstraints()
        }
    }
    
    private var _wingletWidth : CGFloat
    {
        get
        {
            if(windletsVisible)
            {
                return CGFloat(wingletWidth)
            }
            return 0.0
        }
    }
    
    private func UpdateWingletConstraints()
    {
        _editorLeftConstraint.constant = _wingletWidth
        _editorRightConstraint.constant = 0.0 - _wingletWidth
        _leftImageWidthConstraint.constant = _wingletWidth
        _rightImageWidthConstraint.constant = _wingletWidth
    }
    
    private func setIconography()
    {
        _leftWingletImage.image = UIImage(systemName: "plus")
        _rightWingletImage.image = UIImage(systemName: "minus")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touchPoint = touches.first?.location(in: self)
        if(touchPoint!.x < _editor.frame.minX)
        {
            _touchPlacement = .left
            return
        }
        if(touchPoint!.x > _editor.frame.minX + _editor.frame.width)
        {
            _touchPlacement = .right
            return
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        _touchPlacement = .none
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touchPoint = touches.first?.location(in: self)
        if(touchPoint!.x < _editor.frame.minX)
        {
            if(_touchPlacement == .left)
            {
                leftWingletPressed()
            }

        }
        if(touchPoint!.x > _editor.frame.minX + _editor.frame.width)
        {
            if(_touchPlacement == .right)
            {
                rightWingletPressed()
            }
        }
        _touchPlacement = .none
    }
    
}
