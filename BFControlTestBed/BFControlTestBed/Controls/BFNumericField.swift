//
//  BFNumericField.swift
//  NumericTestBed
//
//  Created by Christian Andersen on 28/11/2024.
//

import UIKit

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
        }
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
            _ownerEditor?.processKey(key: BFKey.zero)
            break
        default:
            break
        }
        
            
        
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
    
    
    private func setUp()
    {
        self.delegate = self
        
    }
    
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        BFNumericKeyPad.Create(ownerEditor:  self)
        return true;
    }
    
    @IBInspectable public var isDecimal : Bool = false
    
    
    public func processKey(key : BFKey)
    {
        
    }
    

}
