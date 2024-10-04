//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 4.10.2024.
//

import SwiftUI

struct DailyWeatherView: View {
    let data: [ForecastWeather]
    
    var body: some View {
        VStack {
            ForEach(data, id: \.date) { data in
                DailyWeatherCellView(data: data)
            }
        }
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(data: [ForecastWeather.emptyInit()])
    }
}
