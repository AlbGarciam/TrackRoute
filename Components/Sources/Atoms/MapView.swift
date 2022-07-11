import SwiftUI
import MapKit

public struct MapView: UIViewRepresentable {
    private let region: MKCoordinateRegion
    private let route: [CLLocationCoordinate2D]
    private let markupLocations: [CLLocationCoordinate2D]

    public init(_ region: MKCoordinateRegion,
                _ route: [CLLocationCoordinate2D] = [],
                _ markupLocations: [CLLocationCoordinate2D] = []) {
        self.region = region
        self.route = route
        self.markupLocations = markupLocations
    }

    public func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        let polyline = MKPolyline(coordinates: route, count: route.count)
        mapView.addOverlay(polyline)
        markupLocations.forEach { location in
            let anotation = MKPointAnnotation()
            anotation.coordinate = location
            mapView.addAnnotation(anotation)
        }
        return mapView
    }

    public func updateUIView(_ view: MKMapView, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

public class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
        self.parent = parent
    }

    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemBlue
            renderer.lineWidth = 8
            return renderer
        }
        return MKOverlayRenderer()
    }
}
