//
//  NSManagedObjectContext+Extension.swift
//  UITableView_HCM21_FR_IOS_01_TienTH5
//
//  Created by tientran on 09/04/2021.
//

import UIKit
import CoreData
extension NSManagedObjectContext {
    static var currentContext : NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
