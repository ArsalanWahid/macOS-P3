//
//  ViewController.swift
//  Grid View Browser
//
//  Created by Arsalan Wahid Asghar on 07/01/2021.
//

import Cocoa
import WebKit

class ViewController: NSViewController,WKNavigationDelegate, NSGestureRecognizerDelegate {
    
    var rows:NSStackView!
    var selectedWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //      Make a vertical stack view and add it to view
        rows = NSStackView()
        //        view will be stacks from top to bottom
        rows.orientation = .vertical
        rows.distribution = .fillEqually
        //        need to set false to allow custom layout constrains by code
        rows.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rows)
        
        //        create autolayout constrains the pin stackview to the edges of its container (superview)
        //        Anchors are simplified layers over Auto Layout
        rows.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rows.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rows.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rows.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //      create another stackview by default its orientation is horizontal
        //        will be stacked left to right
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
    
    @IBAction func adjustRows(_ sender: NSSegmentedControl) {
        if sender.selectedSegment == 0 {
            //To add a row
            //            count how many columns are in the first row so far
            let colCount = (rows.arrangedSubviews[0] as! NSStackView).arrangedSubviews.count
            
            //make number of webviews based on existing cols in the first row
            let viewArray = (0 ..< colCount).map {_ in makeWebView()}
            
            //            use array to make a new stack view
            let row = NSStackView(views: viewArray)
            row.distribution = .fillEqually
            rows.addArrangedSubview(row)
        }else {
            //            deleting rows
            //            make sure more than one row exists
            guard rows.arrangedSubviews.count > 1 else { return }
            // pull out the last row
            guard let rowToRemove = rows.arrangedSubviews.last as? NSStackView else { return }
            
            //Loop each col and remove the webview
            for col in rowToRemove.arrangedSubviews {
                col.removeFromSuperview()
            }
            
            //Now remove the stackview
            rows.removeArrangedSubview(rowToRemove)
        }
    }
    
    @IBAction func adjustColumns(_ sender: NSSegmentedControl) {
        if sender.selectedSegment == 0 {
            //            Need to add a column
            for case let row as NSStackView in rows.arrangedSubviews {
                row.addArrangedSubview(makeWebView())
            }
        }else {
            //To delete a column
            
            //pull out the first row
            guard let firstRow = rows.arrangedSubviews.first as? NSStackView else { return }
            
            //make sure this row has two columns
            guard firstRow.arrangedSubviews.count > 1 else { return }
            
            //if conditions pass we are safe to delete a column
            for case let row as NSStackView in rows.arrangedSubviews {
                //loop over every row
                if let last = row.arrangedSubviews.last {
                    //remove the column using the two step process
                    row.removeArrangedSubview(last)
                    last.removeFromSuperview()
                }
            }
        }
    }
    
    //MARK:- Methods
    func makeWebView() -> NSView {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.wantsLayer = true
        webView.load(URLRequest(url: URL(string: "https://www.apple.com")!))
        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(webViewClicked))
//        recognizer.numberOfClicksRequired = 2 causes single double click delay
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
        
        if selectedWebView == nil {
            select(webView: webView)
        }
        
        return webView
    }
    
    func select(webView: WKWebView) {
        selectedWebView = webView
        selectedWebView.layer?.borderWidth = 4
        selectedWebView.layer?.borderColor = NSColor.blue.cgColor
    }
    
    @objc func webViewClicked(recognizer: NSClickGestureRecognizer) {
        // pick the new webview selected
        guard let newSelectedWebView = recognizer.view as? WKWebView else { return }
        
        // set the border width of the old web view to 0
        if let selected = selectedWebView {
            selected.layer?.borderWidth = 0
        }
        
        // Set the border of the new select web view
        select(webView: newSelectedWebView)
    }
    
    func gestureRecognizer(_ gestureRecognizer: NSGestureRecognizer, shouldAttemptToRecognizeWith event: NSEvent) -> Bool {
        if gestureRecognizer.view == selectedWebView {
            return false
        }else {
            return true
        }
    }
}

