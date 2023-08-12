//
//  CycleAnnotationView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 09/08/23.
//

import SwiftUI
import MapKit

struct CycleAnnotationView: View {
    
    var coordinate: MapViewModel.CycleCoordinate
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 0)
                    .frame(width: 30)
                    .background(Color(oromColor: .mappinColor))
                    .cornerRadius(60)
                    .shadow(radius: 3, x: 0, y: 6)
                Image(systemName: "mappin")
                    .font(.headline)
                    .foregroundColor(Color(uiColor: .systemGroupedBackground))
            }
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption2)
                .foregroundColor(Color(oromColor: .mappinColor))
                .offset(x: 0, y: -6)
        }
        .onTapGesture {
            print("\(coordinate.latitude) || \(coordinate.longitude)")
        }
    }
}

struct CycleAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        CycleAnnotationView(coordinate: .init(latitude: 10.45, longitude: -9.87))
    }
}
