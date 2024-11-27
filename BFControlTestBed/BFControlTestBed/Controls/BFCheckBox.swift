//
//  BFCheckBox.swift
//  BFSwiftTherapy
//
//  Created by Christian Andersen on 23/10/2022.
//

import UIKit
import QuartzCore

// MARK:- enums
enum bfCheckboxValue : Int
{
    case checkBoxUnknown = -1,
         checkboxNo = 0,
         checkboxYes = 2
}

public enum bfUnknowenStyle : Int {
case unknownNone = 0,
     unknownQuestion = 1,
     unknownCircle = 2,
     unknownPower = 3,
     unknownFontQuestion = 4
}



@IBDesignable class BFCheckBox: UIControl {
// MARK: - private varibles
    private var _checkboxValue : bfCheckboxValue = .checkBoxUnknown
    private var _checkboxUnkownType : bfUnknowenStyle = .unknownFontQuestion
    private var _animationDurqation : Float = 0.7
    private var _drawWidth : Float = 1.0
    private var _showDisabledCross : Bool = true
    private var _triState : Bool = true
    private var _symbolMargin : Float = 0.0
    private var _drawsCross : Bool = true
    
    

    
    
//    MARK: - Properties
    public var checkboxValue : bfCheckboxValue
    {
        get
        {
            return _checkboxValue
        }
        set(newValue)
        {
            _checkboxValue = newValue
            setNeedsDisplay(self.frame)
        }
    }
    
    public func setValueAnimated(checkboxValue : bfCheckboxValue)
    {
        if(checkboxValue != _checkboxValue)
        {
            _checkboxValue = checkboxValue
            drawSymbol(animate: true)
        }
    }
    
    public var checkboxUnknowenType : bfUnknowenStyle
    {
        get
        {
            return _checkboxUnkownType
        }
        set(newValue)
        {
            _checkboxUnkownType = newValue
        }
    }
    
    
    public var drawsCross : Bool
    {
        get
        {
            return _drawsCross
        }
        set
        {
            _drawsCross = newValue
        }
        
    }
    
    

    
    @IBInspectable
    public var checkColor : UIColor = UIColor.green

    
    @IBInspectable
    public var crossColor : UIColor = UIColor.systemPink

    
    @IBInspectable
    public var unknowenColor : UIColor = UIColor.systemOrange
    
    @IBInspectable
    public var animationDurqation : Float
    {
        get
        {
            return _animationDurqation
        }
        set(newValue)
        {
            _animationDurqation = newValue
        }
    }
    
    @IBInspectable
    public var drawWidth : Float
    {
        get
        {
            return _drawWidth
        }
        set(newValue)
        {
            _drawWidth = newValue
        }
    }
    
    @IBInspectable
    public var showDisabledCross : Bool
    {
        get
        {
            return _showDisabledCross
        }
        set(newvalue)
        {
            _showDisabledCross = newvalue
        }
    }
    
    @IBInspectable
    public var triState : Bool
    {
        get
        {
            return _triState
        }
        set(newValue)
        {
            _triState = newValue
        }
    }
    
    @IBInspectable
    public var borderColor : UIColor?
    {
        get
        {
            if(layer.backgroundColor == nil) {
                return nil
            }
            return UIColor(cgColor: layer.borderColor!)
        }
        set(newValue)
        {
            layer.borderColor = newValue?.cgColor;
        }
    }
    // because this can be changed by trait we need to keep a local copy
    
    @IBInspectable
    public var borderWidth : Float
    {
        get
        {
            return Float(layer.borderWidth)
        }
        set(newValue)
        {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable
    public var borderCornerRadius : Float
    {
        get
        {
            return Float(layer.cornerRadius)
        }
        set(newValue)
        {
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable
    public var symbolMargin : CGFloat
    {
       get
        {
            return CGFloat(_symbolMargin)
        }
        set(newValue)
        {
            _symbolMargin = Float(newValue)
            layoutAnimationLayer()
        }
        
        
    }
    
    
    
    var _animationLayer : CALayer!
    var _pathLayer : CAShapeLayer!
    
//    MARK: - Intilize
    
    private func layoutAnimationLayer()
    {
        if(_animationLayer != nil)
        {
            _animationLayer.frame = CGRect(x: self.bounds.origin.x + 2.0 + CGFloat(_symbolMargin) ,y: self.bounds.origin.y+2.0 + CGFloat(_symbolMargin) ,width: self.bounds.width - (4.0 + (CGFloat(_symbolMargin) * 2)),height: self.bounds.height - (4.0 + (CGFloat(_symbolMargin) * 2)) )
        }
    }
    
    private func layoutPathLayer()
    {
        _pathLayer.frame = CGRect(x: _animationLayer.bounds.origin.x + 2.0,y: _animationLayer.bounds.origin.y+2.0,width: _animationLayer.bounds.width - 4.0,height: _animationLayer.bounds.height - 4.0)
    }
    
    
    
    private func setUp()
    {
        _animationLayer = CALayer()
        _pathLayer = CAShapeLayer()
        _animationLayer.addSublayer(_pathLayer)
        layer.addSublayer(_animationLayer)
        layoutAnimationLayer()
        checkboxValue = .checkBoxUnknown
        borderColor = UIColor.label
        checkColor = UIColor.systemGreen
        crossColor = UIColor.systemRed;
        unknowenColor = UIColor.systemOrange
        animationDurqation  = 0.5
        drawWidth = 3.0
        showDisabledCross = true
        triState = true
        symbolMargin = 0.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        layoutAnimationLayer()
        drawSymbol()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        layoutAnimationLayer()
        drawSymbol()
    }
    
    convenience init()
    {
        self.init()
        setUp()
        layoutAnimationLayer()
        drawSymbol()
    }
    
    
    
    override var frame: CGRect
    {
        get
        {
            return super.frame
        }
        set(newValue)
        {
            super.frame = newValue
            if(_animationLayer != nil )
            {
                layoutAnimationLayer()
            }
        }
    }
    
    
    
//    MARK: - Draw Methods
    
    private func clearSymbol()
    {
        _pathLayer.removeAllAnimations()
    }
    
    
    private func getCrossPath() -> CGPath
    {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 3.0,  y: 3.0))
        path.addLine(to: CGPoint(x: _pathLayer.bounds.width - 3.0, y: _pathLayer.bounds.height - 3.0))
        path.move(to: CGPoint(x: _pathLayer.bounds.width - 3.0, y: 3.0))
        path.addLine(to: CGPoint(x: 3.0, y: _pathLayer.bounds.height - 3.0))
        
        return path.cgPath
    }
    
    
    private func getCheckPath() -> CGPath
    {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: _pathLayer.bounds.width*0.091, y: _pathLayer.bounds.height*0.545))
        path.addLine(to: CGPoint(x: _pathLayer.bounds.width*0.36, y: _pathLayer.bounds.height*0.855))
        path.addLine(to: CGPoint(x: _pathLayer.bounds.width*0.91, y: _pathLayer.bounds.height*0.091))
        
        return path.cgPath
    }

    
    private func getUnkowenPath() ->CGPath
    {
        
        let path = UIBezierPath()
        
        switch checkboxUnknowenType {
        case .unknownNone:
            break
        case .unknownQuestion:
            path.move(to: CGPoint(x: _pathLayer.bounds.width*0.3, y: _pathLayer.bounds.height*0.116))
            
            path.addCurve(to: CGPoint(x: _pathLayer.bounds.size.width*0.478,y: _pathLayer.bounds.size.height*0.066), controlPoint1:CGPoint(x: _pathLayer.bounds.size.width*0.342,y: _pathLayer.bounds.size.height*0.086), controlPoint2: CGPoint(x: _pathLayer.bounds.size.width*0.412,y: _pathLayer.bounds.size.height*0.066))
            path.addCurve(to: CGPoint(x: _pathLayer.bounds.size.width*0.687,y: _pathLayer.bounds.size.height*0.249),  controlPoint1:CGPoint(x: _pathLayer.bounds.size.width*0.622,y: _pathLayer.bounds.size.height*0.066), controlPoint2: CGPoint(x: _pathLayer.bounds.size.width*0.687,y: _pathLayer.bounds.size.height*0.154))
            
            path.addCurve(to: CGPoint(x: _pathLayer.bounds.size.width*0.58,y: _pathLayer.bounds.size.height*0.467), controlPoint1: CGPoint(x: _pathLayer.bounds.size.width*0.687,y: _pathLayer.bounds.size.height*0.334), controlPoint2: CGPoint(x: _pathLayer.bounds.size.width*0.64,y: _pathLayer.bounds.size.height*0.396))
            
            path.addCurve(to: CGPoint(x: _pathLayer.bounds.size.width*0.481,y: _pathLayer.bounds.size.height*0.624), controlPoint1: CGPoint(x: _pathLayer.bounds.size.width*0.525,y: _pathLayer.bounds.size.height*0.532), controlPoint2: CGPoint(x: _pathLayer.bounds.size.width*0.489,y: _pathLayer.bounds.size.height*0.59))
            
            path.move(to: CGPoint(x: _pathLayer.bounds.size.width*0.409,y: _pathLayer.bounds.size.height*0.793) )
            
            path.addCurve(to: CGPoint(x: _pathLayer.bounds.size.width*0.482,y: _pathLayer.bounds.size.height*0.714), controlPoint1: CGPoint(x: _pathLayer.bounds.size.width*0.409,y: _pathLayer.bounds.size.height*0.746), controlPoint2: CGPoint(x: _pathLayer.bounds.size.width*0.482,y: _pathLayer.bounds.size.height*0.714))
            
            path.addCurve(to: CGPoint(x: _pathLayer.bounds.size.width*0.556,y: _pathLayer.bounds.size.height*0.7), controlPoint1: CGPoint(x: _pathLayer.bounds.size.width*0.527,y: _pathLayer.bounds.size.height*0.714), controlPoint2: CGPoint(x: _pathLayer.bounds.size.width*0.556,y: _pathLayer.bounds.size.height*0.746))
            
            path.addCurve(to: CGPoint(x: _pathLayer.bounds.size.width*0.481, y: _pathLayer.bounds.size.height*0.87), controlPoint1: CGPoint(x: _pathLayer.bounds.size.width*0.481,y: _pathLayer.bounds.size.height*0.87), controlPoint2: CGPoint(x: _pathLayer.bounds.size.width*0.556,y: _pathLayer.bounds.size.height*0.87))
            
            path.addCurve(to: CGPoint(x: _pathLayer.bounds.size.width*0.409,y: _pathLayer.bounds.size.height*0.793), controlPoint1: CGPoint(x: _pathLayer.bounds.size.width*0.439,y: _pathLayer.bounds.size.height*0.87), controlPoint2: CGPoint(x: _pathLayer.bounds.size.width*0.409,y: _pathLayer.bounds.size.height*0.836))
            
            path.addArc(withCenter: CGPoint(x: _pathLayer.bounds.size.width*0.49, y: _pathLayer.bounds.size.height*0.84), radius: 0.5, startAngle: 0.0, endAngle: 6.3, clockwise: false)
            
        case .unknownCircle:
            path.addArc(withCenter: CGPoint(x: _pathLayer.bounds.width*0.5, y: _pathLayer.bounds.height*0.5), radius: _pathLayer.bounds.width*0.5 - 3, startAngle: 0.0, endAngle: 6.3, clockwise: true)
            
        case .unknownPower:
            
            path.addArc(withCenter: CGPoint(x: _pathLayer.bounds.width*0.5, y: _pathLayer.bounds.height*0.5), radius: _pathLayer.bounds.width*0.5 - 3, startAngle: 5.0, endAngle: 4.4, clockwise: true)
            path.move(to: CGPoint(x: _pathLayer.bounds.width*0.5, y: _pathLayer.bounds.height * 0.1))
            path.addLine(to: CGPoint(x: _pathLayer.bounds.width*0.5, y: _pathLayer.bounds.height * 0.7))
            
        case .unknownFontQuestion:
            path.move(to: CGPoint(x: 18.136/44.0*_pathLayer.bounds.width, y: 30.121/44.0*_pathLayer.bounds.height) )
            
            path.addLine(to: CGPoint(x: 18.026/44.0*_pathLayer.bounds.size.width, y: 28.691/44.0*_pathLayer.bounds.size.height))
            
            
            
            
            path.addCurve(to: CGPoint(x: 21.436/44.0*_pathLayer.bounds.size.width, y: 19.176/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 17.697/44.0*_pathLayer.bounds.size.width, y: 25.775/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 18.686/44.0*_pathLayer.bounds.size.width, y: 22.476/44.0*_pathLayer.bounds.size.height))
            
            path.addCurve(to: CGPoint(x: 25.285/44.0*_pathLayer.bounds.size.width, y: 11.642/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 23.910/44.0*_pathLayer.bounds.size.width, y: 16.261/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 25.285/44.0*_pathLayer.bounds.size.width, y: 14.116/44.0*_pathLayer.bounds.size.height))
           
            path.addCurve(to: CGPoint(x: 20.061/44.0*_pathLayer.bounds.size.width, y: 6.913/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 25.285/44.0*_pathLayer.bounds.size.width, y: 8.837/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 23.525/44.0*_pathLayer.bounds.size.width, y: 6.968/44.0*_pathLayer.bounds.size.height))
            
            
            path.addCurve(to: CGPoint(x: 14.507/44.0*_pathLayer.bounds.size.width, y: 8.618/44.0*_pathLayer.bounds.size.height), controlPoint1:  CGPoint(x: 18.082/44.0*_pathLayer.bounds.size.width, y: 6.913/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 15.881/44.0*_pathLayer.bounds.size.width, y: 7.573/44.0*_pathLayer.bounds.size.height))
            
            
            path.addLine(to: CGPoint(x: 13.187/44.0*_pathLayer.bounds.size.width, y: 5.153/44.0*_pathLayer.bounds.size.height))
            
            path.addCurve(to: CGPoint(x: 21.051/44.0*_pathLayer.bounds.size.width, y: 2.953/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 15.057/44.0*_pathLayer.bounds.size.width, y: 3.833/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 18.136/44.0*_pathLayer.bounds.size.width, y: 2.953/44.0*_pathLayer.bounds.size.height))
            
            path.addCurve(to: CGPoint(x: 30.235/44.0*_pathLayer.bounds.size.width, y: 11.037/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 27.375/44.0*_pathLayer.bounds.size.width, y: 2.953/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 30.235/44.0*_pathLayer.bounds.size.width, y: 6.858/44.0*_pathLayer.bounds.size.height))
            
            path.addCurve(to: CGPoint(x: 25.506/44.0*_pathLayer.bounds.size.width, y: 20.606/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 30.235/44.0*_pathLayer.bounds.size.width, y: 14.777/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 28.145/44.0*_pathLayer.bounds.size.width, y: 17.471/44.0*_pathLayer.bounds.size.height))
            
            path.addCurve(to: CGPoint(x: 22.371/44.0*_pathLayer.bounds.size.width, y: 28.745/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 23.086/44.0*_pathLayer.bounds.size.width, y: 23.466/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 22.206/44.0*_pathLayer.bounds.size.width, y: 25.940/44.0*_pathLayer.bounds.size.height))
            
            path.addLine(to: CGPoint(x: 22.481/44.0*_pathLayer.bounds.size.width, y: 30.120/44.0*_pathLayer.bounds.size.height))
           
            path.addLine(to: CGPoint(x: 18.136/44.0*_pathLayer.bounds.size.width, y: 30.121/44.0*_pathLayer.bounds.size.height))
            
            
            path.close();
            
            
            
            
            path.move(to: CGPoint(x: 16.981/44.0*_pathLayer.bounds.size.width,y: 37.875/44.0*_pathLayer.bounds.size.height))
            
            path.addCurve(to: CGPoint(x: 20.226/44.0*_pathLayer.bounds.size.width,y: 34.410/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 16.981/44.0*_pathLayer.bounds.size.width,y: 35.840/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 18.356/44.0*_pathLayer.bounds.size.width,y: 34.410/44.0*_pathLayer.bounds.size.height))
           
            
            path.addCurve(to: CGPoint(x: 23.471/44.0*_pathLayer.bounds.size.width,y: 37.875/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 22.205/44.0*_pathLayer.bounds.size.width,y: 34.410/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 23.471/44.0*_pathLayer.bounds.size.width,y: 35.840/44.0*_pathLayer.bounds.size.height))
            
            
            
            path.addCurve(to: CGPoint(x: 20.172/44.0*_pathLayer.bounds.size.width,y: 41.284/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 23.471/44.0*_pathLayer.bounds.size.width,y: 39.799/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 22.206/44.0*_pathLayer.bounds.size.width,y: 41.284/44.0*_pathLayer.bounds.size.height))
            
            path.addCurve(to: CGPoint(x: 16.981/44.0*_pathLayer.bounds.size.width,y: 37.875/44.0*_pathLayer.bounds.size.height), controlPoint1: CGPoint(x: 18.301/44.0*_pathLayer.bounds.size.width,y: 41.284/44.0*_pathLayer.bounds.size.height), controlPoint2: CGPoint(x: 16.981/44.0*_pathLayer.bounds.size.width,y: 39.799/44.0*_pathLayer.bounds.size.height))
            
            
            
        }
        
        return path.cgPath
    }
    
    private func drawSymbol(animate : Bool = true)
    {
        layoutPathLayer()
        if(self.superview != nil)
        {
            _pathLayer.removeAllAnimations()
            _pathLayer.isGeometryFlipped = false
            
            switch checkboxValue {
            case .checkboxNo:
                if(!_drawsCross)
                {
                    _pathLayer.strokeColor = nil
                    _pathLayer.fillColor = nil
                    _pathLayer.path = nil
                } else
                {
                    if(isEnabled  || showDisabledCross)
                    {
                        _pathLayer.strokeColor = crossColor.cgColor
                        _pathLayer.fillColor = nil
                        _pathLayer.lineWidth = CGFloat(drawWidth)
                        _pathLayer.lineJoin = CAShapeLayerLineJoin.bevel
                        _pathLayer.path = getCrossPath()
                    }
                }
                break
            case .checkboxYes:
                _pathLayer.strokeColor = checkColor.cgColor
                _pathLayer.fillColor = nil
                _pathLayer.lineWidth = CGFloat(drawWidth)
                _pathLayer.lineJoin = CAShapeLayerLineJoin.bevel
                _pathLayer.path = getCheckPath()
                break
            case .checkBoxUnknown:
                _pathLayer.strokeColor = unknowenColor.cgColor
                if(checkboxUnknowenType == .unknownFontQuestion)
                {
                    _pathLayer.fillColor = unknowenColor.cgColor
                    _pathLayer.lineWidth = 1.0
                } else
                {
                    _pathLayer.fillColor = nil
                    _pathLayer.lineWidth = CGFloat(drawWidth)
                }
                _pathLayer.lineJoin = CAShapeLayerLineJoin.bevel
                _pathLayer.path = getUnkowenPath()
                break;
            }
            
            if(animate)
            {
                let pathAnimation =  CABasicAnimation(keyPath: "strokeEnd")
                pathAnimation.duration = CFTimeInterval(_animationDurqation);
                pathAnimation.fromValue = 0.0
                pathAnimation.toValue = 1.0
                _pathLayer.add(pathAnimation, forKey: "strokeEnd")
            }
        }
    }
    
    
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        setNeedsDisplay()

        layer.borderColor = borderColor?.cgColor
        drawSymbol(animate: false)
    }
    
//    MARK: - Adctions
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isEnabled)
        {
            if(checkboxValue == .checkBoxUnknown)
            {
//                if(checkboxUnknowenType == .unknownFontQuestion)
//                {
//                    _pathLayer.removeAllAnimations()
//                    _pathLayer.removeFromSuperlayer()
//                    _pathLayer = CAShapeLayer()
//                    _animationLayer.addSublayer(_pathLayer)
//                }
                
//                 needs a start state
                checkboxValue = .checkboxNo
            } else
            {
                if(checkboxValue == .checkboxNo)
                {
                    checkboxValue = .checkboxYes
                } else
                {
                    if( triState)
                    {
                        checkboxValue = .checkBoxUnknown
                    } else
                    {
                        checkboxValue = .checkboxNo
                    }
                }
            }
            sendActions(for: UIControl.Event.valueChanged)
            drawSymbol(animate: true)
        }
    }
    
    

}
