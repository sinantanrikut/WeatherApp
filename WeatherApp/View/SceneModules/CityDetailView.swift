//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 5.10.2024.
//

import SwiftUI
import CoreLocationUI

struct CityDetailView: View {
    var cityName: String // Seçilen şehir ismi buraya gelecek
    @ObservedObject var weatherViewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                if weatherViewModel.stateView == .loading {
                    ActivityIndicatorView(isAnimating: true).configure {
                        $0.color = .white
                    }
                }
                
                if weatherViewModel.stateView == .success {
                    // Şehir adı başlık olarak gösteriliyor
                    Text("Weather in \(cityName)")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    LocationAndTemperatureHeaderView(data: weatherViewModel.currentWeather)
                    Spacer()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            DailyWeatherCellView(data: weatherViewModel.todayWeather)
                            Rectangle().frame(height: 1)
                            
                            HourlyWeatherView(data: weatherViewModel.hourlyWeathers)
                            Rectangle().frame(height: 1)
                            
                            DailyWeatherView(data: weatherViewModel.dailyWeathers)
                            Rectangle().frame(height: 1)
                            
                            Text(weatherViewModel.currentDescription)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 24)
                            
                            Rectangle().frame(height: 1)
                            
                            DetailsCurrentWeatherView(data: weatherViewModel.currentWeather)
                            Rectangle().frame(height: 1)
                        }
                    }
                    Spacer()
                }
                
                if weatherViewModel.stateView == .failed {
                    Button(action: {
                        weatherViewModel.searchWeather(for: cityName)
                    }) {
                        Text("Failed to get data, retry?")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .colorScheme(.dark)
        .onAppear {
            // Seçilen şehir için hava durumu verilerini getir
            weatherViewModel.searchWeather(for: cityName)
        }
    }
}
