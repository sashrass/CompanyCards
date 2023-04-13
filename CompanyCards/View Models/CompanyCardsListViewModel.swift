//
//  CompanyCardsListViewModel.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import Foundation

protocol CompanyCardsListDelegate: ObservableObject {
    
    var allCardsLoaded: Bool { get }
    var cards: [CompanyCardDelegate] { get }
    var loadError: (error: Bool, message: String) { get set }
    
    func loadNextItemsIfNeeded()
}

enum LoadError {
    case message(message: String)
}

class CompanyCardsListViewModel: CompanyCardsListDelegate {
    
    private var webService = WebService()
    
    @Published var allCardsLoaded: Bool = false
    
    @Published var cards: [CompanyCardDelegate] = []
    @Published var loadError: (error: Bool, message: String) = (false, "")
    
    private var currentOffset = -1
    private var isAlreadyLoading = false
    private var itemsLoading: Bool = false
    
    init() {
        fetchCards()
    }
    
    func loadNextItemsIfNeeded() {
        fetchCards()
    }
    
    private func fetchCards() {
        
        if itemsLoading || allCardsLoaded { return }

        itemsLoading = true
        
        webService.fetchCards(.ideal, offset: currentOffset + 1) { [weak self] result in
            
            switch result {
                
            case .success(let companies):
                
                self?.currentOffset += 1
                
                if companies.count == 0 {
                    DispatchQueue.main.async {
                        self?.allCardsLoaded = true
                        self?.itemsLoading = false
                    }
                    return
                }
                
                let newCompanies = companies.map(CompanyCardViewModel.init)
                
                DispatchQueue.main.async {
                    self?.cards.append(contentsOf: newCompanies)
                }
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    if let error = error as? BadRequestError {
                        self?.loadError.message = error.message
                        
                    } else if let _ = error as? AuthorizationError {
                        self?.loadError.message = "Ошибка авторизации"
                        
                    } else {
                        self?.loadError.message = "Все упало"
                    }
                    
                    self?.loadError.error = true
                }
                
            }
            
            self?.itemsLoading = false
            
        }
    }
    
}
