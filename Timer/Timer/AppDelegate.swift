//
//  AppDelegate.swift
//  Timer
//
//  Created by 池田　惇 on 2017/03/30.
//  Copyright © 2017年 jnikd. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    public let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.action = #selector(AppDelegate.togglePopover(_:))
        popover.contentViewController = CustomViewController(nibName: "CustomViewController", bundle: nil)
        
        togglePopover(self)
    }
    
    func togglePopover(_ sender: Any) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            if let button = statusItem.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}

