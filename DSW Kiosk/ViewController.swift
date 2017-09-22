//
//  ViewController.swift
//  DSW Kiosk
//
//  Created by Jay Zeschin on 9/20/17.
//  Copyright © 2017 Denver Startup Week. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!
    
    static let startingUrl = Bundle.main.infoDictionary!["KioskStartingUrl"] as! String
    static let urlRegex = Regex(Bundle.main.infoDictionary!["KioskAllowedHostsRegex"] as! String)
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.customUserAgent = "DSWKiosk"
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        let myURL = URL(string: type(of: self).startingUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if type(of: self).urlRegex.test(input: navigationAction.request.url!.host!.lowercased()) {
            decisionHandler(.allow)
        }
        else
        {
            decisionHandler(.cancel)
        }
    }
}
