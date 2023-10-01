//
//  Router.swift
//  TestProj
//
//  Created by Айбол on 01.10.2023.
//

import UIKit

protocol Router {
    func route(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?
    )
    static func createModule() -> UIViewController
}
