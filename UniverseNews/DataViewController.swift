//
//  DataViewController.swift
//  UniverseNews
//
//  Created by Kenichi Aramaki on 2017/08/03.
//  Copyright © 2017年 competitiveprogramming.info. All rights reserved.
//

import UIKit
import WebKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var usageLabel: UILabel!
    var dataObject: String = ""
    var webView: WKWebView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        webView = WKWebView()
        let url:URL! = URL(string:"https://www.google.com")
        webView.load(URLRequest(url: url))
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
        let r = URLCache.shared.currentDiskUsage
        usageLabel.text = String(format: "%ld", r)
    }
}

