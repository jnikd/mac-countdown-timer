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
        NSApplication.shared.terminate(self)
    }
    
    private lazy var appDelegate: AppDelegate = NSApplication.shared.delegate as! AppDelegate
    private var timer: Timer?
    
    private let dateFormatter: DateFormatter = {
        $0.dateFormat = "YYYY-MM-dd"
        return $0
    }(DateFormatter())
    
    private let dateTimeFormatter: DateFormatter = {
        $0.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return $0
    }(DateFormatter())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CustomViewController.update), userInfo: nil, repeats: true)
    }
    
    @objc func update(){
        let dateString = dateFormatter.string(from: Date())
        let toTimeString = to.stringValue
        let fromTimeString = from.stringValue
        let toTime = dateTimeFormatter.date(from: dateString + " " + toTimeString)
        let fromTime = dateTimeFormatter.date(from: dateString + " " + fromTimeString)
        
        let resultString: String = (toTime != nil && fromTime != nil)
            ? {
                let interval: TimeInterval = $0!.timeIntervalSince($1!)
                let hour = Int(interval / 3600)
                let minute = Int((interval - Double(hour * 3600)) / 60)
                let second = Int(interval - Double(hour * 3600 + minute * 60))
                return String(format: "%02d:%02d:%02d", hour, minute, second)
                }(toTime, fromTime)
            : "00:00:00"
        
        result.stringValue = resultString
        appDelegate.update(string: resultString)
    }
}
