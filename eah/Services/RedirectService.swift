//
//  RedirectService.swift
//  eah
//
//  Created by Danil Ilichev on 02.07.2022.
//

import Foundation
import UIKit

class RedirectService {
    static func goToTelegram() {
        let appURL = NSURL(string: "tg://resolve?domain=eahapp")!
        let webURL = NSURL(string: "https://t.me/eahapp")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
        }
    }
    
    static func goToInstagram() {
        let appURL = URL(string: "instagram://user?username=eahapp")!
        let webURL = URL(string: "https://instagram.com/eahapp")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
        }
    }
    
}
