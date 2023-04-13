//
//  CardCell.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import SwiftUI
import CachedAsyncImage

struct CardCell: View {
    
    let vm: CompanyCardDelegate
    
    var onActionButtonTap: ((_ buttonName: String) -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            headingView
            
            Divider()
            
            bodyView
            
            Divider()
            
            actionsView
        }
        .padding(EdgeInsets(top: Constants.spacingType1,
                            leading: Constants.spacingType1,
                            bottom: Constants.spacingType1,
                            trailing: Constants.spacingType1))
        .background(Color.white1)
        .cornerRadius(25)
    }
    
    private var headingView: some View {
        HStack {
            Text(vm.companyName)
                .font(.system(size: Constants.fontSize1, weight: .light))
                .foregroundColor(Color(hex: vm.highlightTextColor))
            
            Spacer()
            
            CachedAsyncImage(url: URL(string: vm.logoURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white1)
                }
            }

        }
        .padding(EdgeInsets(top: 0,
                            leading: 0,
                            bottom: Constants.spacingType2,
                            trailing: 0))
        
    }
    
    private var bodyView: some View {
        VStack(spacing: Constants.spacingType1) {
            HStack(alignment: .firstTextBaseline, spacing: Constants.spacingType2) {
                Text("\(vm.points)")
                    .font(.system(size: Constants.fontSize1, weight: .semibold))
                    .foregroundColor(Color(hex: vm.highlightTextColor))
                
                Text("баллов")
                    .font(.system(size: Constants.fontSize2))
                    .foregroundColor(Color(hex: vm.textColor))
                    
                Spacer()
            }
            
            HStack(spacing: Constants.spacingType3) {
                
                LoyaltyInfoView(upperText: "Кэшбэк", lowerText: "\(vm.cashback) %", vm: vm)
                
                LoyaltyInfoView(upperText: "Уровень", lowerText: vm.level, vm: vm)
                
                Spacer()
            }
        }
        .padding(EdgeInsets(
            top: Constants.spacingType1,
            leading: 0,
            bottom: Constants.spacingType2,
            trailing: 0))
        
    }
    
    private var actionsView: some View {
        HStack {
            
            HStack(spacing: Constants.spacingType3) {
                
                Button {
                    onActionButtonTap?("Eye")
                } label: {
                    Image("eye")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .colorMultiply(Color(hex: vm.mainColor))
                }

                Button {
                    onActionButtonTap?("Trash")
                } label: {
                    Image("trash")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .colorMultiply(Color(hex: vm.accentColor))
                }

                    
            }
            .padding(EdgeInsets(top: Constants.spacingType1 - Constants.spacingType2,
                                leading: Constants.spacingType1,
                                bottom: 0,
                                trailing: 0))
                
            Spacer()
            
            Button("Подробнее") {
                onActionButtonTap?("Подробнее")
            }
            .frame(width: 170, height: 50)
            .foregroundColor(Color(hex: vm.mainColor))
            .background(Color(hex: vm.backgroundColor))
            .cornerRadius(15)
            
        }
        .padding(EdgeInsets(top: Constants.spacingType2,
                            leading: 0,
                            bottom: 0,
                            trailing: 0))
    }

}

private struct LoyaltyInfoView: View {
    
    let upperText: String
    let lowerText: String
    
    let vm: CompanyCardDelegate
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Text(upperText)
                .foregroundColor(.darkGray1)
                .font(.system(size: Constants.fontSize3))
                .foregroundColor(Color(hex: vm.textColor))
            
            Text(lowerText)
                .font(.system(size: Constants.fontSize2))
        }
    }
}

//struct CardCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CardCell(vm: <#CompanyCardDelegate#>)
//    }
//}
