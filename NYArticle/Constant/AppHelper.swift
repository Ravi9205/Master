//
//  AppHelper.swift
//  Clykk
//
//  Created by Apple on 26/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit


var  activityView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)


extension UIViewController{
    
    func showAlertMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            
            print("Ok Action")
        }))
        self.present(alert, animated: true, completion: nil)
       // UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    func startActivity(){
        activityView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityView.tintColor = UIColor.green
        activityView.transform = transform
        activityView.center = self.view.center
        activityView.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.addSubview(activityView)
    }
    
    func stopActivity(){
        activityView.stopAnimating()
        activityView .removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
    
    func isValidDate(dateString: String) -> Bool {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        if let _ = dateFormatterGet.date(from: dateString) {
            //date parsing succeeded, if you need to do additional logic, replace _ with some variable name i.e date
            return true
        } else {
            // Invalid date
            return false
        }
    }
    
    func color(colorCode:UIColor)->UIColor{
        return UIColor(red: 255/0, green: 255/195, blue: 255/0, alpha: 1.0)
    }
    
    
    func getIFAddresses() -> [String] {
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }
        
        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            var addr = ptr.pointee.ifa_addr.pointee
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return addresses
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "[789][0-9]{9}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}

extension Array {
    public func Dictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
