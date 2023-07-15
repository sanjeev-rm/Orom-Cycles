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
                .frame(maxWidth: .infinity, alignment: .leading)
                
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
                CodeScannerView(codeTypes: [.qr], completion: handleScan)
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
    
    /// This function handles the result after scanning
    /// It's the completion handler for CodeScannerView
    func handleScan(result: Result<ScanResult, ScanError>) {
        dashboardViewModel.toggleShowScanner()
        
        switch result {
        case .success(let result):
            print("YAY Scanned correctly")
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
