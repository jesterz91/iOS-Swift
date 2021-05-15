//
//  ContentView.swift
//  MapView
//
//  Created by lee on 2021/05/15.
//

import SwiftUI
import MapKit

struct ContentView: View {

    @State private var coordinate = CLLocationCoordinate2DMake(37.551416, 126.988194)

    private let locations: [String: CLLocationCoordinate2D] = [
        "남산": CLLocationCoordinate2DMake(37.551416, 126.988194),
        "시청": CLLocationCoordinate2DMake(37.566308, 126.977948),
        "국회": CLLocationCoordinate2DMake(37.531830, 126.914187)
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(coordinate: coordinate)
            HStack(spacing: 30) {
                ForEach(["남산", "시청", "국회"], id: \.self) { location in
                    Button(action: { self.coordinate = self.locations[location]! }) {
                        Text("\(location)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                    }
                }
            }.padding(.bottom, 40)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
