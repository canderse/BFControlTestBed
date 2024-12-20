//
//  BFEnhancedNumberField.swift
//  BFControlTestBed
//
//  Created by Christian Andersen on 1/12/2024.
//

import UIKit
import AudioToolbox

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
    
    public enum BFWingletDirection {
        case clockWide,
        antiClockwise
    }
    
    public enum BFWingletType
    {
        case math,
             chevron,
             arrow,
             triangle,
             triangleFill
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

        }
      
    
        private func playClick()
        {
            AudioServicesPlaySystemSound(1104)
        }
    
    
        private func leftWingletPressed()
        {
            if(iconDirection == .antiClockwise)
            {
                
                if(_editor.isDecimal)
                {
                    let newVal = _editor.doubleValue - 1.0
                    if(!_editor.signButtonVisible && newVal < 0.0 )
                    {
                        _editor.doubleValue = 0.0
                    } else
                    {
                        _editor.doubleValue = newVal;
                        playClick()
                    }
                } else
                {
                    let newVal = _editor.intValue - 1
                    if(!_editor.signButtonVisible && newVal < 0)
                    {
                        _editor.intValue = 0
                    } else
                    {
                        _editor.intValue = _editor.intValue - 1;
                        playClick()
                    }
                }
                
            } else
            {
                if(_editor.isDecimal)
                {
                    _editor.doubleValue = _editor.doubleValue + 1.0;
                } else
                {
                    _editor.intValue = _editor.intValue + 1;
                }
                playClick()
            }
        }
    
        private func rightWingletPressed()
        {
            if(iconDirection == .antiClockwise)
            {
                if(_editor.isDecimal)
                {
                    _editor.doubleValue = _editor.doubleValue + 1.0;
                } else
                {
                    _editor.intValue = _editor.intValue + 1;
                }
                playClick()
            } else
            {
                if(_editor.isDecimal)
                {
                    let newVal = _editor.doubleValue - 1.0
                    if(!_editor.signButtonVisible && newVal < 0.0 )
                    {
                        _editor.doubleValue = 0.0
                    } else
                    {
                        _editor.doubleValue = newVal;
                        playClick()
                    }
                } else
                {
                    let newVal = _editor.intValue - 1
                    if(!_editor.signButtonVisible && newVal < 0)
                    {
                        _editor.intValue = 0
                    } else
                    {
                        _editor.intValue = _editor.intValue - 1;
                        playClick()
                    }
                }
            }
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
        
    
    
   
    public var iconography : BFWingletType = .triangleFill
    {
        didSet
        {
            setIconography()
        }
    }
    
    public var iconDirection : BFWingletDirection = .antiClockwise
    {
        didSet
        {
            setIconography()
        }
    }
    
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
    
    @IBInspectable public var font: UIFont?
    {
        get
        {
            return _editor.font
        }
        set(newValue)
        {
            _editor.font = newValue
        }
    }
    
    @IBInspectable public var placeholderText: String?
    {
        get
        {
            return _editor.placeholder
        }
        set(newValue)
        {
            _editor.placeholder = newValue
        }
    }
        
    @IBInspectable public var signButtonVisible: Bool
    {
        get
        {
            return _editor.signButtonVisible
        }
        set(newValue)
        {
            _editor.signButtonVisible = newValue
        }
    }
    
    
    
    
    @IBInspectable public var isDecimal: Bool
    {
        get
        {
            return _editor.isDecimal
        }
        set(newValue)
        {
            _editor.isDecimal = newValue
        }
    }
    
    @IBInspectable var backSpaceEnabled: Bool
    {
        get
        {
            return _editor.backSpaceEnabled
        }
        set(newValue)
        {
            _editor.backSpaceEnabled = newValue
        }
    }
    
    public var intValue: Int
    {
        get
        {
            return _editor.intValue
        }
        set
        {
            _editor.intValue = newValue
        }
    }
    
    public var doubleValue: Double
    {
        get
        {
            return _editor.doubleValue
        }
        set
        {
            _editor.doubleValue = newValue
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
    
    
    @IBInspectable public var iconPointSize : Float = 10.0
    {
        didSet
        {
            setIconography()
        }
    }
    
    private func setIconography()
    {
        if(iconography == .math)
        {
            if(iconDirection == .clockWide)
            {
                _leftWingletImage.image = UIImage(systemName: "plus")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "minus")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            } else
            {
                _leftWingletImage.image = UIImage(systemName: "minus")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "plus")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            }
            return
        }
        
        if(iconography == .chevron)
        {
            if(iconDirection == .clockWide)
            {
                _leftWingletImage.image = UIImage(systemName: "chevron.up")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "chevron.down")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            } else
            {
                _leftWingletImage.image = UIImage(systemName: "chevron.down")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "chevron.up")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            }
            return
        }
        
        if(iconography == .arrow)
        {
            if(iconDirection == .clockWide)
            {
                _leftWingletImage.image = UIImage(systemName: "arrow.up")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "arrow.down")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            } else
            {
                _leftWingletImage.image = UIImage(systemName: "arrow.down")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "arrow.up")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            }
            return
        }
        
        if(iconography == .triangle)
        {
            if(iconDirection == .clockWide)
            {
                _leftWingletImage.image = UIImage(systemName: "arrowtriangle.up")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "arrowtriangle.down")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            } else
            {
                _leftWingletImage.image = UIImage(systemName: "arrowtriangle.down")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "arrowtriangle.up")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            }
            return
        }
        
        if(iconography == .triangleFill)
        {
            if(iconDirection == .clockWide)
            {
                _leftWingletImage.image = UIImage(systemName: "arrowtriangle.up.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "arrowtriangle.down.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            } else
            {
                _leftWingletImage.image = UIImage(systemName: "arrowtriangle.down.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
                _rightWingletImage.image = UIImage(systemName: "arrowtriangle.up.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: CGFloat(iconPointSize)))
            }
            return
        }
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
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
        let touchPoint = touches.first?.location(in: self)
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
