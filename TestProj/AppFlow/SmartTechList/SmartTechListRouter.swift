//
//  SmartTechListRouter.swift
//  TestProj
//
//  Created by Айбол on 01.10.2023.
//

import UIKit

class SmartTechListRouter: Router {
    private unowned var viewModel: SmartTechListViewModel
    init(viewModel: SmartTechListViewModel) {
        self.viewModel = viewModel
    }
    
    func route(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?)
    {
        guard let route = SmartTechListViewController.Route(rawValue: routeID) else { return }
        switch route {
        case .warningDeleteItem:
            guard let index = parameters as? Int,
                  let device = viewModel.devices?[index] else { return }
            let warningViewController = DeleteWarningViewController(warningTitle: device.name) {
                context.dismiss(animated: true)
            } deleteButtonClosure: {
                self.viewModel.removeDevice(at: index)
                context.dismiss(animated: true)
            }
            warningViewController.modalPresentationStyle = .overCurrentContext
            context.present(warningViewController, animated: true)
        }
    }
    
    static func createModule() -> UIViewController {
        let service = DeviceAPIService()
        let viewModel = SmartTechListViewModel(service: service)
        let router = SmartTechListRouter(viewModel: viewModel)
        let view = SmartTechListViewController(viewModel: viewModel, router: router)
        return view
    }
}
