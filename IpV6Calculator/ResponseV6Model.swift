//
//  ResponseV6Model.swift
//  IpV6Calculator
//
//  Created by Kaan Mercan on 8.12.2022.
//

import Foundation

struct ResponseV6Model: Decodable {
    let data: Data?
    let message: String?
    let success: Bool?
}

// MARK: - DataClass
struct Data: Decodable {
    let ipAddress, subnet, firstIPAddress, lastIPAddress: String?
    let size: String?
    let generatedIPAdresses: String?

    enum CodingKeys: String, CodingKey {
        case ipAddress, subnet
        case firstIPAddress = "firstIpAddress"
        case lastIPAddress = "lastIpAddress"
        case size
        case generatedIPAdresses = "generatedIpAdresses"
    }
}
