//
//  PreloaderView.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import SwiftUI
import UIKit


struct PreloaderView: View {
    
    let textLabel: String
    
    private let circleFill = 0.35
    
    @State private var isRotated = false
    
    private let animation: Animation = Animation.linear(duration: 0.8).repeatForever(autoreverses: false)
    
    var body: some View {
        VStack(spacing: Constants.spacingType2) {
            Ring(ringFill: circleFill)
                .stroke(Color.black1, lineWidth: 3)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isRotated ? 360 : 0))
            
            Text(textLabel)
                .font(.system(size: Constants.fontSize1, weight: .light))
        }
        
        .onAppear {
            withAnimation(animation) {
                self.isRotated = true
            }
        }
        
    }
}


private struct Ring: Shape {
    
    var ringFill: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let start: CGFloat = 0
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2), radius: rect.size.width / 2, startAngle: .degrees(start), endAngle: .degrees(360 * ringFill), clockwise: false)
        
        return path
    }
}

struct PreloaderView_Previews: PreviewProvider {
    static var previews: some View {
        PreloaderView(textLabel: "Подзагрузка компаний")
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
