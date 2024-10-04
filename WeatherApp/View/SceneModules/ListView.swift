//
//  ListView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 5.10.2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct ListView: View {
    @State private var city: String = ""
    @State private var cities: [String] = []
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter City", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)

                Button(action: saveCityToFirestore) {
                    Text("Save City")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .padding(.vertical)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .multilineTextAlignment(.center)
                }

                List {
                    ForEach(cities, id: \.self) { city in
                        HStack {
                            NavigationLink(destination: CityDetailView(cityName: city)) {
                                Text(city)
                                    .font(.headline)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            }

                            Spacer()

                            Button(action: {
                                removeCity(cityName: city)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(Color.red.opacity(0.1))
                                    .cornerRadius(10)
                                    .shadow(color: Color.red.opacity(0.2), radius: 5, x: 0, y: 2)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle()) // Use plain style for the list
                .padding()

                Spacer()
            }
            .padding()
            .onAppear(perform: fetchDefaultCity)
            .navigationTitle("Cities")
            .navigationBarTitleDisplayMode(.inline) // Center the title
        }
        .background(Color(UIColor.systemGroupedBackground)) // Background color for the NavigationView
        .edgesIgnoringSafeArea(.all)
    }

    // Firestore'a şehir kaydetme fonksiyonu
    func saveCityToFirestore() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not authenticated"
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        userRef.setData(["cities": FieldValue.arrayUnion([city])], merge: true) { error in
            if let error = error {
                self.errorMessage = "Error saving city: \(error.localizedDescription)"
            } else {
                self.errorMessage = "City saved successfully!"
                fetchDefaultCity()
            }
        }
    }

    // Firestore'dan şehir listesini yükleme
    func fetchDefaultCity() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not authenticated"
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        userRef.getDocument { document, error in
            if let error = error {
                self.errorMessage = "Error fetching city: \(error.localizedDescription)"
                return
            }

            if let document = document, document.exists {
                self.cities = document.data()?["cities"] as? [String] ?? []
            } else {
                self.errorMessage = "Document does not exist"
            }
        }
    }

    // Firestore'dan şehir silme
    func removeCity(cityName: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData([
            "cities": FieldValue.arrayRemove([cityName])
        ]) { error in
            if let error = error {
                self.errorMessage = "Error removing city: \(error)"
            } else {
                self.errorMessage = "City removed successfully"
                fetchDefaultCity()
            }
        }
    }
}

#Preview {
    ListView()
}
