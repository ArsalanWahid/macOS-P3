//
//  ViewController.swift
//  Grid View Browser
//
//  Created by Arsalan Wahid Asghar on 07/01/2021.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func urlEntered(_ sender: NSTextField) {
        print(sender.stringValue)
    }
    
    @IBAction func navigationClicked(_ sender: NSTextField) {
        print("navigationClicked")
    }
    
    @IBAction func adjustRows(_ sender: NSTextField) {
        print("adjustRows")
    }
    
    @IBAction func adjustColumns(_ sender: NSTextField) {
        print("adjustColumns")
    }
}

