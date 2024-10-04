//
//  DailyView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 4.10.2024.
//

import SwiftUI

struct DailyView: View {
    
    var day: String {
        return "1"
    }
    var temperatureMax: String {
        return "20°"
    }

    var temperatureMin: String {
        return "10°"
    }
    
    var icon: String {
        var image = "logo"
        return image
    }

    var body: some View {
        HStack {
            Text(day)
                .frame(width: 150, alignment: .leading)

            Image(icon)
                .resizable()
                .aspectRatio(UIImage(named: icon)!.size, contentMode: .fit)
                .frame(width: 30, height: 30)

            Spacer()
            Text(temperatureMax)
            Spacer().frame(width: 34)
            Text(temperatureMin)
        }.padding(.horizontal, 24)
    }
}

#Preview {
    DailyView()
}
