//
//  BFTextField.swift
//  BFControlTestBed
//
//  Created by Christian Andersen on 6/12/2024.
//

import UIKit

class BFTextField: UITextField,UITextFieldDelegate {

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
    
    @IBInspectable var textLimit : Int = 0;
    
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
    }
    
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
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
    
     public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textLimit > 0 &&  (text?.count ?? 0 + string.count ) > textLimit)
         {
            return false
         }
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

}
