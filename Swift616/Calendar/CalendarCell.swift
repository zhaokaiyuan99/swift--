//
//  DayCell.swift
//  Swift616
//
//  Created by SunSet on 14-6-16.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import Foundation
import UIKit


class CalendarCell: UIView ,DayCellDelegate{
  
    
    var headView:UIView?
    var year:Int?
    var month:Int?
    var masterLabel:UILabel?
    
    var weekLabelArray:NSMutableArray?
    var dayLabelArray:NSMutableArray?
    
    init(frame: CGRect, year: Int ,month:Int) {
        super.init(frame: frame)
        weekLabelArray = NSMutableArray();
        dayLabelArray = NSMutableArray();
        self.year = year;
        self.month = month;
        self.setup();
    }
    
    func updateMonthView(){
        masterLabel!.text = String(self.month!)
        var xOffset:CGFloat = self.frame.size.width/7.0;
        var yOffset:CGFloat = 44.0;
        var monthDay:Int = Datecalculate.getDayCountOf(self.month!, year: self.year!)
        var startNumber:Int = Datecalculate.getStart(self.month!, year: self.year!)
        for (var i:Int = 0; i<dayLabelArray!.count; i++) {
            var numberX:Int = (i+startNumber) % 7;
            var numberY:Int =  (i+startNumber) / 7;
            var cell:DayCell = dayLabelArray!.objectAtIndex(i)as DayCell
            cell.frame = CGRectMake(CGFloat(numberX) * xOffset, 70 + CGFloat(numberY) * yOffset, xOffset, yOffset)
            
            cell.delegate = self
            cell.month = self.month;
            cell.year = self.year;
            cell.setDay( i+1)
            if (i>=monthDay) {
                cell.hidden = true;
            }else{
                cell.hidden = false;
            }
        }
    }
    
    func createMonthView( ){
        var xOffset:CGFloat = self.frame.size.width/7.0;
        var yOffset:CGFloat = 44.0;
        var startNumber:Int = Datecalculate.getStart(self.month!, year: self.year!)
        for (var i:Int = 0; i<32; i++) {
            var numberX:Int = (i+startNumber)%7;
            var numberY:Int =  (i+startNumber)/7;
            var cell:DayCell = DayCell(frame: CGRectMake(CGFloat(numberX)*xOffset, 70 +  CGFloat(numberY) * yOffset, xOffset, yOffset))
            self.addSubview(cell);
            dayLabelArray!.addObject(cell)
            cell.setDay(i+1)
        }
   
    }
    var TapDayCell:( (year:Int,month:Int,day:Int )->Void)?

    func changeItem(year:Int,month:Int,day:Int){
       TapDayCell!(year: year,month: month,day: day)
    }
    
    func setup(){
        headView = UIView(frame: CGRectMake(0, 0, 320, 70))
        self.addSubview(headView);
        headView!.backgroundColor = UIColor.whiteColor()
        
        var view:UIView = UIView(frame: CGRectMake(0, headView!.frame.size.height-0.3, headView!.frame.size.width, 0.3))
        self.addSubview(view) 
        
        view.backgroundColor = UIColor.colorWithHexString("c1c1c1")
            
     
        
        masterLabel = UILabel(frame: CGRectMake(4, 10, 30, 30))
        masterLabel!.backgroundColor = UIColor.clearColor()
        masterLabel!.textAlignment = NSTextAlignment.Right
        masterLabel!.font = UIFont(name: "HelveticaNeue", size: 26.0)
        masterLabel!.text = String(self.month!)
        headView!.addSubview(masterLabel)
     
        var masterLabelUnit:UILabel = UILabel(frame: CGRectMake(masterLabel!.frame.origin.x+masterLabel!.frame.size.width, 16.0, 34, 24))
        masterLabelUnit.backgroundColor = UIColor.clearColor()
        masterLabelUnit.textAlignment = NSTextAlignment.Left
        masterLabelUnit.font = UIFont(name: "HelveticaNeue", size: 20.0)
        masterLabelUnit.text = "月"
        masterLabelUnit.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        headView!.addSubview(masterLabelUnit)
  
        var  xOffset:CGFloat = self.frame.size.width/7.0;
        var  yOffset:CGFloat = 44.0
   
        for (var i:Int = 0 ; i<7; i++) {
            var dayOfTheWeekLabel:UILabel = UILabel(frame: CGRectMake(xOffset*CGFloat(i), yOffset, xOffset, 20))
            dayOfTheWeekLabel.textColor = UIColor.blackColor()
            dayOfTheWeekLabel.textAlignment = NSTextAlignment.Center
            dayOfTheWeekLabel.backgroundColor = UIColor.clearColor()
            dayOfTheWeekLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
            headView!.addSubview(dayOfTheWeekLabel)
            weekLabelArray!.addObject(dayOfTheWeekLabel)
           
        }
        self.updateWithDayNames(["日","一","二","三","四","五","六"])
        self.createMonthView()
    }
    

    func updateWithDayNames(dayNames:NSArray){
        for (var i:Int = 0 ; i < dayNames.count; i++) {
            var label:UILabel =  weekLabelArray!.objectAtIndex(i) as UILabel
            label.text = dayNames[i] as String
            if (i==0) {
                label.textColor = UIColor.orangeColor()
                
            }
            if (i == dayNames.count-1) {
                label.textColor = UIColor.orangeColor()
            }
        
        }
    }
    
    
}


