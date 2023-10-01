//
//  SmartTechListViewModel.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation

protocol SmartTechListViewModelProtocol {
    func getDevices()
    func removeDevice(at index: Int)
}

final class SmartTechListViewModel: NSObject, SmartTechListViewModelProtocol {
    public var bindEmployeeViewModelToController : (() -> ()) = {}
    private let service: DeviceAPIServiceProtocol
    private(set) var devices: [Device]? = nil {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    init(service: DeviceAPIServiceProtocol) {
        self.service = service
    }
    
    func getDevices() {
        service.getDevices { result in
            switch result {
            case .success(let response):
                self.devices = response.data
            case .failure:
                self.devices = nil
            }
        }
    }
    
    func removeDevice(at index: Int) {
        devices?.remove(at: index)
        bindEmployeeViewModelToController()
    }
}
