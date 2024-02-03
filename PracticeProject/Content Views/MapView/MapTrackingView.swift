//
//  MapTrackingView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 14/11/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapTrackingView: View {
    
    @State private var userCurrentLocation: CLLocationCoordinate2D?
    @State private var camera: MapCameraPosition = .automatic

    let locationManager = CLLocationManager()

    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            Map(position: $camera) {
                // Add a default marker using the user's current location
                if let location = userCurrentLocation {
                    Marker("Your Location", systemImage: "location", coordinate: location)
                }
            }.mapStyle(.standard)
            
            // Button to set the camera to the user's current location
            Button {
                if let location = userCurrentLocation {
//                    camera = .region(MKCoordinateRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200))
                }
                camera = .userLocation(fallback: .automatic)

            } label: {
                withAnimation {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .foregroundStyle(Color.btnGradientColor)
                        .padding(.all, 10)
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(10)
            .background(Color.clear)
            .padding()
        }
        .onAppear {
            fetchUserLocation()
            camera = .userLocation(fallback: .automatic)
        }
    }
    
    private func fetchUserLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
}


#Preview {
    MapTrackingView()
}
