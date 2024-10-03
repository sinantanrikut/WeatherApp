//
//  LaunchScreen.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Color.white
            
            Image("turkcellBgLogo")
                .accessibilityHidden(true)
            
            VStack {
                Image("hayalOrtagimLogoText")
                    .resizable()
                    .frame(width: 238,height: 197)
                    .accessibility(label: Text("Hayal Ortağım Uygulaması"))

            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    LaunchScreen()
}
