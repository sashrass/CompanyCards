//
//  CompanyResponse.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import Foundation

struct CompanyResponse: Decodable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let dashboard: DashboardInfo
    
    enum CodingKeys: String, CodingKey {
        case company
        case customerMarkParameters
        case dashboard = "mobileAppDashboard"
    }
}

struct Company: Decodable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "companyId"
    }
}

struct CustomerMarkParameters: Decodable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Double
}

struct LoyaltyLevel: Decodable {
    let level: Int
    let name: String
    let requiredSum: Double
    let markToCash: Double
    let cashToMark: Double
    
    enum CodingKeys: String, CodingKey {
        case level = "number"
        case name
        case requiredSum
        case markToCash
        case cashToMark
    }
}

struct DashboardInfo: Decodable {
    let companyName: String
    let logo: String
    let backgroundColor: String
    let mainColor: String
    let cardBackgroundColor: String
    let textColor: String
    let highlightTextColor: String
    let accentColor: String
}
