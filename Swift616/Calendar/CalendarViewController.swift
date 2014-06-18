//
//  CalendarViewController.swift
//  Swift616
//
//  Created by SunSet on 14-6-17.
//  Copyright (c) 2014 SunSet. All rights reserved.
//

import UIKit

class CalendarViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
 
    var table:UITableView?
    var dataArray:NSMutableArray?
    var fromDate:DateObject?
    var toDate:DateObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.whiteColor();
        dataArray = NSMutableArray()
        var fromYear:Int = 2014;
        var toYear:Int = 2016;
        var fromMonth:Int = 1;
        var toMonth:Int = 1;
        var number:Int = ( toYear - fromYear ) * 12 + toMonth - fromMonth + 1
        
        for (var i:Int = 0 ; i<number; i++)
        {
            var object:DateObject = DateObject()
            object.year  = fromYear
            object.month = fromMonth + i
           
            object.year = fromYear + (fromMonth+i) / 12
            
            if object.month! % 12 == 0 {
                object.year = object.year! - 1
                object.month =  fromMonth + i - (fromMonth+i) / 12 * 12 + 12
            }else{
                object.month =  fromMonth + i - (fromMonth+i) / 12 * 12

            }
    
            
            
            println( object.year)
            println( object.month)
            if object.month == 0 {
                println( object.year)
                println( fromMonth )
                println( i )
                
                
                
            }
 
            
            dataArray!.addObject(object)
        }
        
        table = UITableView(frame: self.view.frame )
        table!.backgroundColor = UIColor.clearColor()
        table!.separatorColor = UIColor.clearColor()
        table!.delegate = self
        table!.dataSource = self
        self.view.addSubview(table)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell") as UITableViewCell
             cell!.selectionStyle = UITableViewCellSelectionStyle.None
            var calendarCell:CalendarCell = CalendarCell(frame: CGRectMake(0, 0, 310, 400), year: 2014, month: 1)
            cell!.contentView.addSubview(calendarCell)
            calendarCell.tag = 1000001
        } 
    
   
        var cellView:CalendarCell = cell!.contentView.viewWithTag(1000001) as CalendarCell
        var row:Int = indexPath.row
        var object:DateObject = self.dataArray!.objectAtIndex(row) as DateObject
        cellView.year = object.year
        cellView.month = object.month
        cellView.TapDayCell = {(year:Int,month:Int,day:Int ) in
            println(year);
             println(month);
             println(day);
        }
        cellView.updateMonthView()
        return cell!
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat{
        var object  = self.dataArray!.objectAtIndex(indexPath.row) as DateObject
        var layer = Datecalculate.getLayer(object.year!, month: object.month!)
        var y = 70 + 44 * layer
        return Float(y)
    }

}

