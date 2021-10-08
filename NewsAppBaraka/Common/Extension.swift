//
//  Extension.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 08/10/21.
//

import UIKit
import SafariServices

// UIapplication
extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}

// MARK:- SFSafariViewController

extension SFSafariViewController {
    
    public static func openWithSafariVC(url: URL, from: UIViewController) {
        var updatedUrl = url
        if url.absoluteString.lowercased().starts(with: "http") == false {
            if let urlWithHttp = URL(string: "http://"+url.absoluteString) {
                updatedUrl = urlWithHttp
            } else {
                return
            }
        }
        let configuration = SFSafariViewController.Configuration.init()
        let safariVC = SFSafariViewController.init(url: updatedUrl, configuration: configuration)
        safariVC.preferredControlTintColor = .purple
        from.present(safariVC, animated: true, completion: nil)
    }
}

