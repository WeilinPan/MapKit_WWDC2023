//
//  BeantownButtons.swift
//  WWDC2023_MapKit_Demo
//
//  Created by 潘威霖 on 2023/8/21.
//

import SwiftUI
import MapKit

struct BeantownButtons: View {
    
    @Binding var position: MapCameraPosition
    
    @Binding var searchResults: [MKMapItem]
    
    var body: some View {
        HStack {
            Button {
                search(for: "playground")
            } label: {
                Label("Playgrounds", systemImage: "figure.and.child.holdinghands")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "beach")
            } label: {
                Label("Beaches", systemImage: "beach.umbrella")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "starbucks")
            } label: {
                Label("starbucks", systemImage: "cup.and.saucer.fill")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                position = .region(.boston)
            } label: {
                Label("Boston", systemImage: "building.2")
            }
            .buttonStyle(.bordered)
            
            Button {
//                position = .region(.northShore)
//                position = .item(MKMapItem(placemark: MKPlacemark(coordinate: .hotpot)))
//                position = .rect(MKMapRect(origin: MKMapPoint(.hotpot), size: MKMapSize()))
//                position = .camera (
//                    MapCamera (
//                        centerCoordinate: CLLocationCoordinate2D(
//                            latitude: 42.360431,
//                            longitude: -71.055930
//                    ),
//                        // 地圖中心點到相機的距離，以米為單位。
//                    distance: 980,
//                        // 相機相對真北的角度
//                    heading: 242,
//                        // 相機角度俯視平面狀態為0
//                    pitch: 80
//                    )
//                )
                position = .userLocation(fallback: .automatic)
            } label: {
                Label("North Shore", systemImage: "water.waves")
            }
            .buttonStyle(.bordered)
        }
        .labelStyle(.iconOnly)
    }
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: .parking,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

#Preview {
    BeantownButtons(position: Binding(get: {
        return .automatic
    }, set: { _ in
        
    }), searchResults: Binding(get: {
        return [MKMapItem]()
    }, set: { _ in
        
    }))
}
