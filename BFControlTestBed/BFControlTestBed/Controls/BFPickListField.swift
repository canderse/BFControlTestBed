//
//  BFPickListField.swift
//  BFControlTestBed
//
//  Created by Christian Andersen on 7/12/2024.
//

import UIKit

public struct BFPicklistIntValue
{
    public var key : Int
    public var value : String
}

public struct BFPicklistStringValue
{
    public var key : String
    public var value : String
}


typealias BFPicklistIntValues = Array<BFPicklistIntValue>
typealias BFPicklistStringValues = Array<BFPicklistStringValue>

class BFPickListField: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public var picklistValuesIntKey : BFPicklistIntValues? = nil
    {
        didSet
        {
            if(picklistValuesIntKey != nil)
            {
                
            }
        }
    }
    
    public var picklistValuesStringKey : BFPicklistStringValues? = nil
    {
        didSet
        {
            if(picklistValuesStringKey != nil)
            {
                picklistValuesIntKey = nil
            }
        }
    }
    
    private func buildMenu()
    {
        var menuItems : Array<UIMenuElement> = Array<UIMenuElement>()
        if(picklistValuesIntKey != nil)
        {
            for picklistValue in picklistValuesIntKey! {
                menuItems.append(UIAction(title: picklistValue.value, identifier: UIAction.Identifier(String(picklistValue.key)), handler: menuItemSelected))
            }
        }
        if(picklistValuesStringKey != nil)
        {
            for picklistValue in picklistValuesStringKey! {
                menuItems.append(UIAction(title: picklistValue.value, identifier: UIAction.Identifier(picklistValue.key), handler: menuItemSelected))
            }
        }
        
        showsMenuAsPrimaryAction = true
        menu = UIMenu(children: menuItems)
    }
    
    private var _selectedIndex : Int = -1
    public var stringKey : String?
    {
        get
        {
            if(_selectedIndex == -1)
            {
                return nil
            }
            if(picklistValuesIntKey != nil)
            {
                return String(picklistValuesIntKey![_selectedIndex].key)
            }
            if(picklistValuesStringKey != nil)
            {
                return picklistValuesStringKey![_selectedIndex].key
            }
        }
        set(newValue)
        {
            if(menu != nil)
            {
                for index in 0...menu!.children.count - 1
                {
                    if((menu!.children[index] as! UIAction).identifier.rawValue == newValue)
                    {
                        _selectedIndex = index;
                        (menu!.children[index] as! UIAction).state = .on
                    } else
                    {
                        (menu!.children[index] as! UIAction).state = .off
                    }
                }
            }
        }
    }
    
    public var IntKey : Int?
    {
        get
        {
            if ( _selectedIndex == -1 || picklistValuesIntKey == nil )
            {
                return nil
            }
            return picklistValuesIntKey![_selectedIndex].key
        }
        set(newValue)
        {
            if(menu != nil && newValue != nil)
            {
                for index in 0...menu!.children.count - 1
                {
                    if((menu!.children[index] as! UIAction).identifier.rawValue == String(newValue!))
                    {
                        _selectedIndex = index;
                        (menu!.children[index] as! UIAction).state = .on
                    } else
                    {
                        (menu!.children[index] as! UIAction).state = .off
                    }
                }
            }
        }
    }
    
    public var value : String?
    {
        get
        {
            if(_selectedIndex == -1)
            {
                return nil
            }
            if(picklistValuesIntKey != nil)
            {
                return picklistValuesIntKey![_selectedIndex].value
            }
            if(picklistValuesStringKey != nil)
            {
                return picklistValuesStringKey![_selectedIndex].value
            }
        }
    }
    
    private func menuItemSelected(action : UIAction)
    {
        sendActions(for: .valueChanged)
    }
    

}
