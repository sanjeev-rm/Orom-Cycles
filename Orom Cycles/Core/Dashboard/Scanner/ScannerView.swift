//
//  ScannerView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var tripViewModel: TripViewModel
    
    var body: some View {
        ZStack() {
            
            VStack {
                Button {
                    // Dissmiss view
                    dashboardViewModel.toggleShowScanner()
                } label: {
                    Image(systemName: "xmark")
                }
                .padding()
                .padding(.top, 16)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                VStack(spacing: 8) {
                    Text("Find a cycle and scan the QR")
                        .font(.title3)
                        .foregroundColor(.primary.opacity(0.8))
                    
                    Text("Place the QR code inside the area")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            if dashboardViewModel.showScanner {
                CodeScannerView(codeTypes: [.qr], simulatedData: "64885b58d383a32d308f5c9c\nCycle 7", completion: handleScan)
                    .cornerRadius(2)
                    .background(
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                    )
                    .padding(.horizontal, 45)
                    .frame(height: UIScreen.main.bounds.width - 90)
            }
        }
    }
    
    /// - This function handles the result after scanning
    /// - It's the completion handler for CodeScannerView
    func handleScan(result: Result<ScanResult, ScanError>) {
        dashboardViewModel.toggleShowScanner()
        
        switch result {
        case .success(let scanResult):
            print("YAY Scanned correctly")
            // Scanning the QR code returns two lines of string the 1st line contains the cycle number, the second line contains the cycle name
            let cycleIdAndName = scanResult.string.split(separator: "\n")
            tripViewModel.cycleId = String(cycleIdAndName[0])
            tripViewModel.cycleName = String(cycleIdAndName[1])
            dashboardViewModel.toggleShowStartRide()
        case .failure(let error):
            print("Scanning failed : \(error.localizedDescription)")
        }
    }
}



struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
