//
//  BFNumericField.swift
//  NumericTestBed
//
//  Created by Christian Andersen on 28/11/2024.
//

import UIKit
import AudioToolbox

public enum BFKey : Int
{
    case zero = 0,
         one = 1,
         two = 2,
         three = 3,
         four = 4,
         five = 5,
         six = 6,
         seven = 7,
         eight = 8,
         nine = 9,
         backSpace = -1,
        clear = -2,
        decimalPoint = -3,
        invertSign = -4,
        closeKeyboard = -99,
        none = -404
}

@IBDesignable class BFNumericKeyPad : UIInputView
{
    

    @IBOutlet weak var zeroButton: UIButton!
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var decimalPointButton: UIButton!
    
    @IBOutlet weak var closeKeyboardButton: UIButton!
    @IBOutlet weak var invertSignButton : UIButton!

    
    
    
    
    override public init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        setUp()
    }
    
//    override public init(frame: CGRect)
//    {
//        super.init(frame: frame);
//        setUp()
//    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    convenience init()
    {
        self.init()
        setUp()
    }
    
    private func setUp()
    {
//        backgroundColor = UIColor.blue
    }
    
    private weak var _ownerEditor : BFNumericField? = nil;
    
    
    static public func Create(ownerEditor : BFNumericField )
    {
        let keyPad = Bundle.main.loadNibNamed("BFNumericKeyPad-Standard", owner: ownerEditor, options: .none)?[0] as? BFNumericKeyPad
        if(keyPad != nil)
        {
            keyPad!._ownerEditor = ownerEditor
            keyPad!.allowsSelfSizing = true
            ownerEditor.inputView = keyPad
            ownerEditor.inputAssistantItem.allowsHidingShortcuts = true
            ownerEditor.inputAssistantItem.leadingBarButtonGroups = []
            ownerEditor.inputAssistantItem.trailingBarButtonGroups = []
            keyPad!.decimalPointButton.isHidden = !ownerEditor.isDecimal
            keyPad!.invertSignButton.isHidden = !ownerEditor.signButtonVisible
            keyPad!.backButton.isHidden = !ownerEditor.backSpaceEnabled
            keyPad!.clearButton.isHidden = !keyPad!.backButton.isHidden
            keyPad!.closeKeyboardButton.isHidden = false
            keyPad!.backButton.isEnabled = !(ownerEditor.text?.isEmpty ?? false)
            keyPad!.clearButton.isEnabled = keyPad!.backButton.isEnabled
        }
    }
    
    
    private func playSoundWithId(id : Int)
    {
        
    }
    
    @IBAction func buttonTouched(_ sender: UIButton)
    {
        switch(sender)
        {
        case zeroButton:
            _ownerEditor?.processKey(key: BFKey.zero)
            break
        case oneButton:
            _ownerEditor?.processKey(key: BFKey.one)
            break
        case twoButton:
            _ownerEditor?.processKey(key: BFKey.two)
            break
        case threeButton:
            _ownerEditor?.processKey(key: BFKey.three)
            break
        case fourButton:
            _ownerEditor?.processKey(key: BFKey.four)
            break
        case fiveButton:
            _ownerEditor?.processKey(key: BFKey.five)
            break
        case sixButton:
            _ownerEditor?.processKey(key: BFKey.six)
            break
        case sevenButton:
            _ownerEditor?.processKey(key: BFKey.seven)
            break
        case eightButton:
            _ownerEditor?.processKey(key: BFKey.eight)
            break
        case nineButton:
            _ownerEditor?.processKey(key: BFKey.nine)
            break
        case clearButton:
            _ownerEditor?.processKey(key: BFKey.clear)
            break
        case backButton:
            _ownerEditor?.processKey(key: BFKey.backSpace)
            break;
        case decimalPointButton:
            _ownerEditor?.processKey(key: BFKey.decimalPoint)
            break;
        case invertSignButton:
            _ownerEditor?.processKey(key: BFKey.invertSign)
            break;
        case closeKeyboardButton:
            _ownerEditor?.processKey(key: BFKey.closeKeyboard)
        default:
            break
        }
        backButton.isEnabled = !(_ownerEditor?.text?.isEmpty ?? false)
        clearButton.isEnabled = backButton.isEnabled
    }
    
    
    
}

@IBDesignable public class BFNumericField: UITextField,UITextFieldDelegate
{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
    
    @IBInspectable public var isDecimal : Bool = false
    @IBInspectable public var signButtonVisible : Bool = false
    @IBInspectable public var backSpaceEnabled : Bool = false
    
    private var _localDelegate : (any UITextFieldDelegate)? = nil
    
    override public var delegate: (any UITextFieldDelegate)?
    {
        get
        {
            return _localDelegate
        }
        set(newValue)
        {
            _localDelegate = newValue
        }
    }
    
    private func setUp()
    {
        super.delegate = self
        textAlignment = .right
        
    }
    
    
    private func playClick()
    {
        AudioServicesPlaySystemSound(1104)
    }
    
    override public func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        BFNumericKeyPad.Create(ownerEditor:  self)
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textFieldShouldBeginEditing(_:))) ?? false)
        {
            return _localDelegate!.textFieldShouldEndEditing!(textField)
        }
        return true;
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textFieldDidBeginEditing(_:))) ?? false)
        {
            _localDelegate!.textFieldDidBeginEditing!(textField)
        }
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:))) ?? false)
        {
            return _localDelegate!.textFieldShouldEndEditing!(textField)
        }
        return true
    }
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textFieldDidEndEditing(_:))) ?? false)
        {
             _localDelegate!.textFieldDidEndEditing!(textField)
        }
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textFieldDidChangeSelection(_:))) ?? false)
        {
             _localDelegate!.textFieldDidChangeSelection!(textField)
        }
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textFieldShouldClear(_:))) ?? false)
        {
             return _localDelegate!.textFieldShouldClear!(textField)
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textFieldShouldReturn(_:))) ?? false)
        {
             return _localDelegate!.textFieldShouldReturn!(textField)
        }
        return true
    }
    
     public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textFieldDidEndEditing(_:))) ?? false)
        {
            _localDelegate!.textFieldDidEndEditing!(textField)
        }
    }
    
     public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textField(_:shouldChangeCharactersIn:replacementString:))) ?? false)
         {
             return _localDelegate!.textField!(textField, shouldChangeCharactersIn: range, replacementString: string)
         }
         return true;
    }
    
    public func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
        if #available(iOS 16.0, *) {
            if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textField(_:editMenuForCharactersIn:suggestedActions:))) ?? false)
            {
                return _localDelegate!.textField!(textField, editMenuForCharactersIn: range, suggestedActions: suggestedActions )
            }
        }
        return nil
    }
    
    
    @available(iOS 16.0, *)
    public func textField(_ textField: UITextField, willDismissEditMenuWith animator: any UIEditMenuInteractionAnimating) {
         if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textField(_:willDismissEditMenuWith:))) ?? false)
            {
                _localDelegate!.textField!(textField, willDismissEditMenuWith: animator)
            }
    }
    
    @available(iOS 16.0, *)
    public func textField(_ textField: UITextField, willPresentEditMenuWith animator: any UIEditMenuInteractionAnimating) {
        if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textField(_:willPresentEditMenuWith:))) ?? false)
           {
                _localDelegate!.textField!(textField, willPresentEditMenuWith: animator)
           }
    }

    
    public func processKey(key : BFKey)
    {
        if(key.rawValue >= 0)
        {
          
            let newChar = Character(UnicodeScalar( "0".unicodeScalars.first!.value + UInt32(key.rawValue))!)
            if(_localDelegate?.responds(to: #selector(UITextFieldDelegate.textField(_:shouldChangeCharactersIn:replacementString:))) ?? false)
            {
               if(_localDelegate!.textField!(self, shouldChangeCharactersIn: NSRange(location: 0,length: text!.count), replacementString: String(newChar)))
               {
                   addCharacterToValue(newChar)
                   playClick()
               }
            } else
            {
                addCharacterToValue(newChar)
                playClick()
            }
        } else
        {
            if(key == BFKey.decimalPoint && isDecimal)
            {
                if(!text!.contains("."))
                {
                    addCharacterToValue(".")
                    playClick()
                }
            } else if(text != nil)
            {
                
                if (key == BFKey.clear)
                {
                    text = ""
                } else if(key == BFKey.backSpace && text != nil)
                {
                    text = String(text!.dropLast())
                } else if(key == BFKey.invertSign)
                {
                    if(text!.contains("."))
                    {
                        if var numericValue = Double(text!)
                        {
                            numericValue = 0 - numericValue
                            text = String(numericValue)
                        }
                    } else
                    {
                        if var numericValue = Int(text!)
                        {
                            numericValue = 0 - numericValue
                            text = String(numericValue)
                        }
                    }
                    
                } else if(key == BFKey.closeKeyboard)
                {
                    endEditing(true)
                }
            }
            
        }


    }

    
  


    
    private func addCharacterToValue(_ newChar : Character)
    {
        text = text! + String(newChar)
    }
    
}
