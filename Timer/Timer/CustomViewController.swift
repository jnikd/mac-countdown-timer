//
//  CustomViewController.swift
//  Timer
//
//  Created by 池田　惇 on 2017/03/30.
//  Copyright © 2017年 jnikd. All rights reserved.
//

import Cocoa

class CustomViewController: NSViewController {
    
    @IBOutlet weak var result: NSTextField!
    @IBOutlet weak var to: NSTextField!
    @IBOutlet weak var from: NSTextField!
    @IBAction func quit(_ sender: NSButton) {
        NSApplication.shared().terminate(self)
    }
    
    private let appDelegate: AppDelegate = NSApplication.shared().delegate as! AppDelegate
    private var timer: Timer!
    
    let dateFormatter: DateFormatter = {
        $0.dateFormat = "YYYY-MM-dd"
        return $0
    }(DateFormatter())
    
    let dateTimeFormatter: DateFormatter = {
        $0.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return $0
    }(DateFormatter())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CustomViewController.update), userInfo: nil, repeats: true)
        
        appDelegate.statusItem.action = #selector(AppDelegate.togglePopover(_:))
        appDelegate.statusItem.title = "00:00:00"
    }
    
    func update(){
        let dateString = dateFormatter.string(from: Date())
        let toTimeString = to.stringValue
        let fromTimeString = from.stringValue
        let toTime = dateTimeFormatter.date(from: dateString + " " + toTimeString)
        let fromTime = dateTimeFormatter.date(from: dateString + " " + fromTimeString)
        
        let safeFromTime: Date = (fromTime != nil) ? fromTime! : Date()
        let safeToTime: Date = (toTime != nil) ? toTime! : Date()
        
        let time = safeToTime.timeIntervalSince(safeFromTime)
        let hour = Int(time / 3600)
        let minute = Int((time - Double(hour * 3600)) / 60)
        let second = Int(time - Double(hour * 3600 + minute * 60))
        result.stringValue = String(format: "%02d:%02d:%02d", hour, minute, second)
        appDelegate.statusItem.title = String(format: "%02d:%02d:%02d", hour, minute, second)
    }
}
