//
//  CompanyCardViewModel.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import Foundation

protocol CompanyCardDelegate {
    
    var companyId: String { get }
    var companyName: String { get }
    var points: String { get }
    var cashback: String { get }
    var level: String { get }
    var logoURL: String { get }
    
    var backgroundColor: String { get }
    var mainColor: String  { get }
    var cardBackgroundColor: String  { get }
    var textColor: String  { get }
    var highlightTextColor: String  { get }
    var accentColor: String  { get }
    
}

struct CompanyCardViewModel: CompanyCardDelegate {

    let model: CompanyResponse
    
    var companyId: String { model.company.id }
    
    var companyName: String { model.dashboard.companyName }
    
    var points: String { String(model.customerMarkParameters.loyaltyLevel.level) }
    
    var cashback: String {
        let cashbackPercent = model.customerMarkParameters.loyaltyLevel.cashToMark / model.customerMarkParameters.mark
        return String(format: "%.2f", cashbackPercent)
    }
    
    var level: String { model.customerMarkParameters.loyaltyLevel.name }
    
    var backgroundColor: String { model.dashboard.backgroundColor }
    
    var mainColor: String { model.dashboard.mainColor }
    
    var cardBackgroundColor: String { model.dashboard.cardBackgroundColor }
    
    var textColor: String { model.dashboard.textColor }
    
    var highlightTextColor: String { model.dashboard.highlightTextColor }
    
    var accentColor: String  { model.dashboard.accentColor }
    
    var logoURL: String { model.dashboard.logo }
    
}
