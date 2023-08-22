//
//  ContentView.swift
//  WWDC2023_MapKit_Demo
//
//  Created by 潘威霖 on 2023/8/21.
//

import SwiftUI
import MapKit

extension MKCoordinateRegion {
    static let boston = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.360256, longitude: -71.057279),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    static let northShore = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.547408, longitude: -70.870085),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
}

extension CLLocationCoordinate2D {
    
    static let parking = CLLocationCoordinate2D(latitude: 42.354528, longitude: -71.068369)

    static let stand_1 = CLLocationCoordinate2D(latitude: 42.354655896697416, longitude: -71.06780684373602)
 
    static let stand_2 = CLLocationCoordinate2D(latitude: 42.35468513299399, longitude: -71.06772101305162)
  
    static let stand_3 = CLLocationCoordinate2D(latitude: 42.35459791959453, longitude: -71.06766669832166)
   
    static let stand_4 = CLLocationCoordinate2D(latitude: 42.35456917878864, longitude: -71.06775319955827)
    
    static let stand_center = CLLocationCoordinate2D(latitude: 42.35462485933613, longitude: -71.06773725770259)
    
    static let circle = CLLocationCoordinate2D(latitude: 42.35466400959054, longitude: -71.06812724900927)
    
    static let bridge = CLLocationCoordinate2D(latitude: 42.35413641504186, longitude: -71.06992812384465)
    
    static let ducklings = CLLocationCoordinate2D(latitude: 42.35551758472192, longitude: -71.0697581168929)
    
    static let hotpot = CLLocationCoordinate2D(latitude: 25.07655721882271, longitude: 121.38582975457757)
}
struct ContentView: View {
    @State private var position: MapCameraPosition = .automatic
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
//        marker
//        annotation
//        search
//        customContentMarker
        mapCameraPosition
    }
}

extension ContentView {
    
    var marker: some View {
        Map {
            //        Marker("Parking", coordinate: .parking)
            
            Marker("Parking", systemImage: "car" , coordinate: .parking)
        }
    }
    
    var annotation: some View {
        Map {
            Annotation("Parking", coordinate: .parking) {
                Image(systemName: "car")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(Color.indigo)
                    .cornerRadius(4)
            }
            .annotationTitles(.hidden)
        }
    }
    
    var search: some View {
        Map {
            Annotation("Parking", coordinate: .parking) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 5)
                    Image(systemName: "car")
                        .padding(5)
                }
            }
            .annotationTitles(.hidden)
            
            ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                BeantownButtons(position: $position, searchResults: $searchResults)
                    .padding(.top)
                Spacer()
            }
            .background(.thinMaterial)
        }
    }
    
    var customContentMarker: some View {
        // Markers with custom content and tint
        Map {
            Marker("Parking", systemImage: "car.fill",
                   coordinate: .parking
            )
            .tint(.mint)

            /// 顯示字符，最多三個字
            Marker("Foot Bridge", monogram: "FB",
                   coordinate: .bridge
            )
            .tint(.blue)
            
            Marker ("Ducklings", image: "DucklingAsset",
                    coordinate: .ducklings
            )
            .tint(.orange)
        }
    }
    
    var mapCameraPosition: some View {
        Map(position: $position) {
            Annotation("Parking", coordinate: .parking) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 5)
                    Image(systemName: "car")
                        .padding(5)
                }
            }
            .annotationTitles(.hidden)
            
            ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                BeantownButtons(position: $position, searchResults: $searchResults)
                    .padding(.top)
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: searchResults) {
            position = .automatic
        }
    }
}

#Preview {
    ContentView()
}
