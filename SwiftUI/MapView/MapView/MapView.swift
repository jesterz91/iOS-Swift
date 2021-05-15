//
//  MapView.swift
//  MapView
//
//  Created by lee on 2021/05/15.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    let coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {

        let camera = MKMapCamera(
            lookingAtCenter: coordinate, // 지도의 중앙 위치
            fromDistance: 2500, // 지정한 중앙 위치로부터 카메라의 거리(m)
            pitch: 45, // 카메라 각도
            heading: 0 // 방향
        )

        uiView.setCamera(camera, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {

    static var previews: some View {

        MapView(coordinate: CLLocationCoordinate2DMake(37.566308, 126.977948))
    }
}
