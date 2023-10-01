//
//  Device.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation

struct Devices: Codable {
    var data: [Device]?
}

struct Device: Codable {
    var id: Int
    var name: String?
    var icon: String?
    var isOnline: Bool?
    var type: Int?
    var status: String?
    var lastWorkTime: Int?
}

enum DeviceStatus: String, Codable {
    case on = "Работает"
    case off = "Выключен"
}
