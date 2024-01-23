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
    
    let myCurrentLocation = CLLocationCoordinate2D(latitude:23.011336543822395 , longitude: 72.51981302500232)
    @State var camera: MapCameraPosition = .automatic
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            Map(position: $camera){
                Marker("Home",systemImage: "shareplay",coordinate: myCurrentLocation)
            }.mapStyle(.standard)
                Button{
                    camera = .region(MKCoordinateRegion(center: myCurrentLocation, latitudinalMeters: 200, longitudinalMeters: 200))
                }label: {
                    Image(systemName: "paperplane").resizable()
                        .foregroundStyle(Color.black)
                        .padding(.all,10)
                }
                
                .frame(width: 40,height: 40)
                .cornerRadius(5)
                .background(Color.white)
            .padding()
            
        }
    }
}

#Preview {
    MapTrackingView()
}
