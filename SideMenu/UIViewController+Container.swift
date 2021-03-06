//
//  UIViewController+Container.swift
//  SideMenu
//
//  Created by kukushi on 2018/8/8.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit

extension UIViewController {

    func load(_ viewController: UIViewController?, on view: UIView) {
        guard let viewController = viewController else {
            return
        }

        // `willMoveToParentViewController:` is called automatically when adding

        addChildViewController(viewController)

        viewController.view.frame = view.bounds
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(viewController.view)

        viewController.didMove(toParentViewController: self)
    }

    func unload(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }

        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
        // `didMoveToParentViewController:` is called automatically when removing
    }
}
