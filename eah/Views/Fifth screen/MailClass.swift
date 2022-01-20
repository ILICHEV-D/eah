//
//  MailClass.swift
//  eah
//
//  Created by Danil Ilichev on 10.01.2022.
//

import Foundation
import MessageUI

class EmailHelper: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailHelper()
    private override init() {
    }
    
    func sendEmail(subject:String, body:String, to:String){
        if !MFMailComposeViewController.canSendMail() {
            return
        }
        
        let picker = MFMailComposeViewController()
        
        picker.setSubject(subject)
        picker.setMessageBody(body, isHTML: true)
        picker.setToRecipients(["support@eahapp.ru"])
        picker.mailComposeDelegate = self
        
        EmailHelper.getRootViewController()?.present(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
    }
    
    static func getRootViewController() -> UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
}
