//
//  BFNunmericField.swift
//  BFControlTestBed
//
//  Created by Christian Andersen on 28/11/2024.
//

import UIKit


fileprivate class BFNumericKeyboard: UIView
{
 
    
    
    
}


@IBDesignable class BFNunmericField: UITextField,UITextFieldDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    convenience init()
    {
        self.init();
        setUp();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private var _customKeyboard: BFNumericKeyboard? = nil;
    
    private func getKeyboard() -> UIView?
    {
        let keyboardView  = Bundle.main.loadNibNamed("BFNumericKeyPad-Standard", owner: self)![0] as! UIView
        return keyboardView // as? BFNumericKeyboard
    }
    
    private func setUp()
    {
        inputView = getKeyboard()
    }
    
}
        
