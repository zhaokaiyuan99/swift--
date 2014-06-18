//
//  DayCell.swift
//  Swift616
//
//  Created by SunSet on 14-6-16.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DayCellDelegate : NSObjectProtocol {
    @optional func changeItem(year:Int,month:Int,day:Int)
}



class DayCell: UIView {
    var button:UIButton?
    var dayLabel:UILabel?
    var explainLabel:UILabel?
    var day:Int?
    var month:Int?
    var year:Int?
    var delegate:DayCellDelegate?
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        
        button = UIButton.buttonWithType(UIButtonType.Custom)as? UIButton
        button!.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        button!.backgroundColor = UIColor.clearColor()
        button!.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(self.button)
        
        dayLabel = UILabel(frame: self.bounds)
        dayLabel!.textAlignment = NSTextAlignment.Center
        dayLabel!.font = UIFont(name: "HelveticaNeue-Light" , size: 18.0);
        dayLabel!.backgroundColor = UIColor.clearColor()
        addSubview(dayLabel)
        
        explainLabel = UILabel(frame: CGRectMake(0, self.frame.size.height/2, self.frame.size.width, 20))
        explainLabel!.textAlignment = NSTextAlignment.Center
        explainLabel!.font = UIFont.boldSystemFontOfSize(14.0)
        explainLabel!.backgroundColor = UIColor.clearColor()
        explainLabel!.tag = 100
       explainLabel!.text = "今天"
        
        
        addSubview(explainLabel)
        explainLabel!.hidden = true
        
        var view:UIView = UIView(frame: CGRectMake(0, self.frame.size.height-0.3, self.frame.size.width, 0.3));
        view.backgroundColor = UIColor.colorWithHexString("c1c1c1")
        addSubview(view)
    }
    
    
    func buttonAction(sender: UIButton)
    {
        delegate?.changeItem?(year!, month: month!, day: day!)
    }
    
    func isToday()->Bool
    {

        var today = NSCalendar.currentCalendar().components(NSCalendarUnit.EraCalendarUnit|NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit, fromDate: NSDate()) as NSDateComponents
         if today.day == self.day && today.month == self.month && today.year == self.year{
            return true;
        }else{
            return false;
        }
    }
    
    
    func isFuture()->Bool{
        var today = NSCalendar.currentCalendar().components(NSCalendarUnit.EraCalendarUnit|NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit, fromDate: NSDate()) as NSDateComponents
        
        if self.year > today.year {
            return true
        }else if (self.year == today.year && self.month>today.month){
            return true;
        }else if (self.year == today.year && self.month==today.month && self.day > today.day){
            return true;
        }
        return false;
    }
    
    
    
    func setDay(newDay:Int){
        self.day = newDay;
        dayLabel!.text = String(newDay)
        if self.isToday(){
            dayLabel!.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)
            explainLabel!.hidden = false
            explainLabel!.textColor = UIColor.orangeColor()
            dayLabel!.textColor = UIColor.orangeColor()
            self.userInteractionEnabled = true
        }else{
            dayLabel!.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
            explainLabel!.hidden = true
            if self.isFuture(){
                dayLabel!.textColor = UIColor.blackColor()
                self.userInteractionEnabled = false
            }else{
                dayLabel!.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
                self.userInteractionEnabled = true;
                button!.setImage(nil, forState: UIControlState.Normal)
                button!.setImage(nil, forState: UIControlState.Selected)
                dayLabel!.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            
            
            }
        }
    }
 
}





 