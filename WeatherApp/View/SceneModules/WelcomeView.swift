//
//  WelcomView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 4.10.2024.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                if weatherViewModel.stateView  == .loading {
                    ActivityIndicatorView(isAnimating: true).configure {
                        $0.color = .white
                    }
                }
                
                if weatherViewModel.stateView  == .success {
                    // Arama çubuğu
                    TextField("Search for a city...", text: $searchText, onCommit: {
                        weatherViewModel.searchWeather(for: searchText)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, 24)

                    LocationAndTemperatureHeaderView(data: weatherViewModel.currentWeather)
                    Spacer()
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            DailyWeatherCellView(data: weatherViewModel.todayWeather)
                            Rectangle().frame(height: CGFloat(1))
                            
                            HourlyWeatherView(data: weatherViewModel.hourlyWeathers)
                            Rectangle().frame(height: CGFloat(1))
                            
                            DailyWeatherView(data: weatherViewModel.dailyWeathers)
                            Rectangle().frame(height: CGFloat(1))
                            
                            Text(weatherViewModel.currentDescription)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(
                                    .init(arrayLiteral:.leading,.trailing),
                                    24
                                )
                            Rectangle().frame(height: CGFloat(1))
                            
                            DetailsCurrentWeatherView(data: weatherViewModel.currentWeather)
                            Rectangle().frame(height: CGFloat(1))
                            
                        }
                    }
                    Spacer()
                }
                
                if weatherViewModel.stateView == .failed {
                    Button(action: {
                        self.weatherViewModel.retry()
                    }) {
                        Text("Failed get data, retry?")
                            .foregroundColor(.white)
                    }
                }
            }
        }.colorScheme(.dark)
            .onAppear {
                // Görünüm açıldığında hava durumunu al
                if let location = locationManager.location {
                    let latitude = location.latitude
                    let longitude = location.longitude
                    weatherViewModel.updateLocation(latitude: latitude, longitude: longitude) // Konumu güncelle
                    
                    weatherViewModel.getData(latitude: latitude, longitude: longitude)
                } else {
                    // Konum mevcut değilse varsayılan şehir için hava durumu al
                    weatherViewModel.fetchWeatherForDefaultCity()
                }
            }
    }
}

#Preview {
    WelcomeView()
}
