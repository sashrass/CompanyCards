//
//  ContentView.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CompanyCardsListView(vm: CompanyCardsListViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
