//
//  ViewController.swift
//  Grid View Browser
//
//  Created by Arsalan Wahid Asghar on 07/01/2021.
//

import Cocoa
import WebKit

class ViewController: NSViewController,WKNavigationDelegate {
    
    var rows:NSStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
//      Make a vertical stack view and add it to view
        rows = NSStackView()
        rows.orientation = .vertical
        rows.distribution = .fillEqually
        rows.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rows)
        
//        create autolayout constrains the pin stackview to the edges of its container (superview)
        rows.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rows.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rows.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rows.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//      create initial column that contains a single webview
        let column = NSStackView(views: [makeWebView()])
        column.distribution = .fillEqually
//
        rows.addArrangedSubview(column)
    }
    
    override var representedObject: Any? {
        didSet {
            
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
    
    //MARK:- Methods
    func makeWebView() -> NSView {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.wantsLayer = true
        webView.load(URLRequest(url: URL(string: "https://www.apple.com")!))
        return webView
    }
}

