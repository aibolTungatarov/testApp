//
//  DeviceService.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation
import Network

protocol DeviceAPIServiceProtocol {
    func getDevices(completion: @escaping(Result<Devices, APIError>) -> Void)
}

final class DeviceAPIService: DeviceAPIServiceProtocol {
    private var network: Networking
    
    init(network: Networking = NetworkingInstance()) {
        self.network = network
    }
    
    func getDevices(completion: @escaping(Result<Devices, APIError>) -> Void) {
        network.execute(DevicesApi.devices, completion: completion)
    }
}
