//
//  BaseViewController.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    open var isAppearedAtLeast = false
    open var isAppeared = false
    
    
    // MARK: - Overrides
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            self.navigationItem.backButtonDisplayMode = .minimal
        } else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isAppearedAtLeast {
            isAppearedAtLeast = true
        }
        isAppeared = true
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isAppeared = false
    }
}
