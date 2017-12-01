//
//  Utility.swift
//  Election
//
//  Created by Raman Kakkar on 11/25/16.
//  Copyright © 2016 Atinder. All rights reserved.
//

import UIKit
import MBProgressHUD
import SystemConfiguration

class Utility
{
    static let sharedInstance = Utility()
  
    // MARK:- Show Loader
    static func showLoader(viewController: UIViewController)
    {
        isLoader = true
        DispatchQueue.main.async {
         var hud : MBProgressHUD = MBProgressHUD()
        hud = MBProgressHUD.showAdded(to: viewController.view, animated: true)
        hud.label.text = "Loading..."
        }
    }
    // MARK:- Hide Loader
    static func hideLoader(viewController: UIViewController)
    {
        isLoader = false
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: viewController.view, animated: true)
            viewController.view.endEditing(true)
        }
    }
    // MARK:- Show Alert
    static func showAlert(viewController: UIViewController,title: String,message: String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    // MARK:- Valid Email
   static func isValidEmail(textEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: textEmail)
    }
    // MARK:- Network Available
   static func isNetworkAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    // MARK:- Network Notifier

     func startNetworkNotifier()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        reachability = Reachability.init()
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
  
    }
    
      @objc func reachabilityChanged(note: Notification) {
        let r = note.object as! Reachability
        if r.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
                if ILinkPlayer.sharedInstance.currentItem != nil
                {
                    if !ILinkPlayer.sharedInstance.isPlaying()
                    {
                        ILinkPlayer.sharedInstance.play()
                    }
                }
            } else {
                print("Reachable via Cellular")
                if ILinkPlayer.sharedInstance.currentItem != nil
                {
                    if ILinkPlayer.sharedInstance.isPlaying()
                    {
                        ILinkPlayer.sharedInstance.pause()
                    }
                }
            }
        } else {
            print("Network not reachable")
        }
    }
    
    // MARK:- Set setNavigationBarColor
   static func setNavigationBarColor(color:UIColor,fontSize:CFloat)
    {
          UINavigationBar.appearance().barTintColor = color
          UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white,NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(fontSize))]
    }
    
    static func compareDateWithTodayDate(date:Date) -> Bool
    {
        let todayDate = Date()
        
        if date > todayDate
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    static func hideKeyboard(vc:UIViewController) -> Void
    {
        DispatchQueue.main.async {
            vc.navigationController?.view.endEditing(true)
            vc.view.endEditing(true)
        }
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
   
}
// MARK:- String Comparison
extension String {
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
}
// MARK:- Valid Phone Number
extension String {
    var isValidPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.characters.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

extension String {
    func split(withLength length: Int) -> [String] {
        return stride(from: 0, to: self.characters.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return self[start..<end]
        }
    }
}

extension UIViewController {
    
    func showToast(message : String) {
        
        if isToast {
            if let theLabel = self.view.viewWithTag(500000) as? UILabel {
                theLabel.text = message
            }
            return
        }
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.tag = 500000
        self.view.addSubview(toastLabel)
        isToast = true
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            isToast = false
        })
    } }

