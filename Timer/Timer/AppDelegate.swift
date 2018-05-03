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
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private let popover: NSPopover = {
        $0.contentViewController = CustomViewController(nibName: NSNib.Name(rawValue: "CustomViewController"), bundle: nil)
        return $0
    }(NSPopover())
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.action = #selector(AppDelegate.togglePopover(_:))
        togglePopover(self)
    }
    
    /// ポップオーバーの表示をトグル
    @objc func togglePopover(_ sender: Any) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            if let button = statusItem.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    /// ステータスバーの表示を更新
    ///
    /// - Parameter string: 表示する文字列
    func update(string: String)  {
        statusItem.title = string
    }
}

