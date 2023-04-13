//
//  ListHeaderView.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import SwiftUI

struct ListHeaderView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: Constants.fontSize1))
                .foregroundColor(.blue1)
            .padding([.top, .bottom], Constants.spacingType1)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.white)
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView(text: "Управление картами")
    }
}
