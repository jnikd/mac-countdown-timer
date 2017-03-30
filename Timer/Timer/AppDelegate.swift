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

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    @IBOutlet weak var menu: NSMenu!
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menu = NSMenu()
        self.statusItem.title = "Timer"
        self.statusItem.highlightMode = true
        self.statusItem.menu = menu
        
        let quitItem = NSMenuItem()
        quitItem.title = "Quit Application"
        quitItem.action = #selector(AppDelegate.quit(_:))
        menu.addItem(quitItem)
        
        statusItem.action = #selector(AppDelegate.togglePopover(_:))
        popover.contentViewController = NSViewController(nibName: "CustomViewController", bundle: nil)
    }
    
    func togglePopover(_ sender: Any){
        if popover.isShown{
            closePopover(sender)
        }else{
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: Any){
        if let button = statusItem.button{
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(_ sender: Any){
        popover.performClose(sender)
    }
    
    func quit(_ sender: Any){
        NSApplication.shared().terminate(self)
    }
}

