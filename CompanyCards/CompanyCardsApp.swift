//
//  CompanyCardsApp.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import SwiftUI

@main
struct CompanyCardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        configureCacheSettings()
    }
    
    private func configureCacheSettings() {
        URLCache.shared.memoryCapacity = 10_000_000
        URLCache.shared.diskCapacity = 1_000_000_000
    }

}
