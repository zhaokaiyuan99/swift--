//
//  DayCell.swift
//  Swift616
//
//  Created by SunSet on 14-6-16.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//
import Foundation

class Datecalculate: NSObject{
    class func getDayCountOf(month:Int , year:Int)->Int{
        switch (month) {
        case 1:
            return 31
        case 3:
            return 31
        case 4:
            return 30
        case 5:
            return 31
        case 6:
            return 30
        case 7:
            return 31
        case 8:
            return 31
        case 9:
            return 30
        case 10:
            return 31
        case 11:
            return 30
        case 12:
            return 31
        default:
            break
        }
        if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
        {
            return 29
        }
        else {
            return 28
        }
    }
    
    
    class func getStart(month:Int , year:Int)->Int{
        var baseNumber:Int
        var startNumber:Int
        
        if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
        {
            switch (month) {
            case 1:
                baseNumber = 0
                
            case 2:
                baseNumber = 3
                
            case 3:
                baseNumber = 4
                
            case 4:
                baseNumber = 0
                
            case 5:
                baseNumber = 2
                
            case 6:
                baseNumber = 5
                
            case 7:
                baseNumber = 0
                
            case 8:
                baseNumber = 3
                
            case 9:
                baseNumber = 6
                
            case 10:
                baseNumber = 1
                
            case 11:
                baseNumber = 4
                
            case 12:
                baseNumber = 6
                
            default:
                baseNumber = 0
            }
            startNumber = (year + year/4 + year/400 - year/100 - 2 + baseNumber + 1) % 7
        }
            
        else
        {
            switch (month) {
            case 1:
                baseNumber = 0
            case 2:
                baseNumber = 3
            case 3:
                baseNumber = 3
            case 4:
                baseNumber = 6
            case 5:
                baseNumber = 1
            case 6:
                baseNumber = 4
            case 7:
                baseNumber = 6
            case 8:
                baseNumber = 2
            case 9:
                baseNumber = 5
            case 10:
                baseNumber = 0
            case 11:
                baseNumber = 3;
                break;
            case 12:
                baseNumber = 5
            default:
                baseNumber = 0
            }
            startNumber = (year + year/4 + year/400 - year/100 - 1 + baseNumber + 1) % 7
        }
        return startNumber
    }

    class func getLayer(year:Int , month:Int)->Int{
        var monthDay =  self.getDayCountOf(month, year: year)
        var startNumber =  self.getStart(month, year: year)
        var newLayer =  startNumber+monthDay
        var layer = ceilf(Float(startNumber+monthDay)/7)
        return Int(layer);
    }
}