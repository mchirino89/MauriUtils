//
//  UIViewController.swift
//  MauriUtils
//
//  Created by Mauricio Chirino on 1/4/20.
//  Copyright © 2020 Mauricio Chirino. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// Checks whether the current view controller is visible the window
    var isVisible: Bool {
        self.view.window != nil
    }
}
