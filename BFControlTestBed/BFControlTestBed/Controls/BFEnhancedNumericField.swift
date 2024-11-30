//
//  BFEnhancedNumericField.swift
//  BFControlTestBed
//
//  Created by Christian Andersen on 30/11/2024.
//

import UIKit

@IBDesignable  class BFEnhancedNumericField: UIControl {

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
    
    
    private let _backingView = UIView()
    private let _numericEditor = BFNumericField()
    
    
    private func setUp()
    {
        //  add the numeric editor
        addSubview(_backingView)
        addSubview(_numericEditor)
        backgroundColor = .clear
    }
    
    
    override var backgroundColor: UIColor?
    {
        get
        {
            return _numericEditor.backgroundColor
        }
        set(newValue)
        {
            _numericEditor.backgroundColor = newValue
        }
    }
    
    public var textColor: UIColor?
    {
        get
        {
            return _numericEditor.textColor
        }
        set(newValue)
        {
            _numericEditor.textColor = newValue
        }
    }
    
    
    public var delegate : UITextFieldDelegate?
    {
        get
        {
            return _numericEditor.delegate
        }
        set(newValue)
        {
            _numericEditor.delegate = newValue
        }
    }
    
    
    
    

}
