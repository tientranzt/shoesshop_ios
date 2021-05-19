import Foundation
import SwiftSMTP

struct MailManager {
    
    static func sentMailViaUserEmail(userEmail : String) {
        let smtp = SMTP(
            hostname: "smtp.gmail.com",
            email: "mamabibi16049@gmail.com",
            password: "523198999"   ,
            port: 587
        )
        
        
        let mail = Mail(
            from: Mail.User(name: "ShoeShop", email: "shoper@wordwide.cc"),
            to: [Mail.User(name: "User", email: "\(userEmail)")],
            subject: "Order Success",
            text: "Your order have been success. Thanks for your ordered goods at my shop."
        )
        
        smtp.send(mail) { (error) in
            if let error = error {
                print("Message: \(error)")
            }
        }
    }
}
