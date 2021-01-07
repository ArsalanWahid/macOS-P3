//
//  windowController.swift
//  Grid View Browser
//
//  Created by Arsalan Wahid Asghar on 08/01/2021.
//

import Cocoa

class windowController: NSWindowController {
    
    @IBOutlet var addressEntry: NSTextField!
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.titleVisibility = .hidden
        
    }
    
    
    
}
