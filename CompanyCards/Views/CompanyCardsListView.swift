//
//  CompanyCardsListView.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import SwiftUI

struct CompanyCardsListView<VM>: View where VM: CompanyCardsListDelegate {
    
    @ObservedObject var vm: VM
    
    @State private var infoAlert: (isPresented: Bool, message: String) = (false, "")
    
    @State private var userInDownloadZone = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            ListHeaderView(text: "Управление картами")
            
            ScrollView {
                
                LazyVStack(spacing: Constants.spacingType1) {
                    ForEach(vm.cards, id: \.companyId) { card in
                        CardCell(vm: card, onActionButtonTap: { buttonName in
                            infoAlert.message = "Нажата кнопка \(buttonName). ID компании: \(card.companyId)"
                            infoAlert.isPresented = true
                        })
                    }
                    Rectangle()
                        .frame(width: 0, height: 0)
                        .onAppear {
                            userInDownloadZone = true
                            vm.loadNextItemsIfNeeded()
                        }
                    
                        .onDisappear {
                            userInDownloadZone = false
                        }
                }
                .padding(Constants.spacingType1)
                
                if !vm.allCardsLoaded {
                    PreloaderView(textLabel: "Подзагрузка компаний")
                }
            }
            
        }
        .background(Color.lightGray1)
        
        .alert("Ошибка", isPresented: $vm.loadError.error) {
            Button("OK") {
                if userInDownloadZone {
                    vm.loadNextItemsIfNeeded()
                }
            }
        }   message: {
            Text(vm.loadError.message)
        }
        
        .alert("Нажата кнопка", isPresented: $infoAlert.isPresented) {
            Button("OK") { }
        } message: {
            Text(infoAlert.message)
        }
        
    }
    
}



struct CompanyCardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCardsListView(vm: CompanyCardsListViewModel())
            .previewDevice("iPhone XS Max")
    }
}
