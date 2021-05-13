//
//  UIWindow+Extension.swift
//  shoe_shop2
//
//  Created by Nhat on 5/12/21.
//

import UIKit
extension UIWindow {
    // use to get is landsape or not
    static var isLandscape: Bool {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows
                    .first?
                    .windowScene?
                    .interfaceOrientation
                    .isLandscape ?? false
            } else {
                return UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
}
