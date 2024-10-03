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
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200,height: 200)
                    .accessibility(label: Text("SwiftUI Weather App Task Uygulaması"))
                Text("SwiftUI Weather App")
                    .font(.setCustom(fontStyle: .title2, fontWeight: .bold))
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    LaunchScreen()
}
