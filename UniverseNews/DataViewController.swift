//
//  DataViewController.swift
//  UniverseNews
//
//  Created by Kenichi Aramaki on 2017/08/03.
//  Copyright © 2017年 competitiveprogramming.info. All rights reserved.
//

import UIKit
import WebKit

class DataViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var usageLabel: UILabel!
    var dataObject: String = ""
    var webView: WKWebView!
//    var webView: UIWebView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let url:URL! = URL(string:"https://www.google.com")

        let config: WKWebViewConfiguration! = WKWebViewConfiguration()
        if #available(iOS 9, *) {
            config.websiteDataStore = WKWebsiteDataStore.default()
        }
        webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
/*
        webView = UIWebView()
        webView.loadRequest(URLRequest(url: url))
*/
    }

    deinit {
        webView.removeFromSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        webView.frame = view.frame
        webView.frame.origin.x = dataLabel.frame.origin.x
        webView.frame.origin.y += dataLabel.frame.origin.y + dataLabel.frame.height;
        webView.frame.size.width -= dataLabel.frame.origin.x * 2;
        webView.frame.size.height -= 120
        view.addSubview(webView)
        updateUsage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }

    func updateUsage() {
        usageLabel.text = String(format: "MEM: %lld KB, DISK: %lld KB", URLCache.shared.currentMemoryUsage / 1024, URLCache.shared.currentDiskUsage / 1024)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if (navigationAction.navigationType == .linkActivated) {
            if (navigationAction.sourceFrame.isMainFrame && navigationAction.targetFrame == nil) {
                print("OPENING NEW WINDOW")
                decisionHandler(.cancel)
                webView.load(navigationAction.request)
                return
            }
        }
        decisionHandler(.allow)
    }
}
