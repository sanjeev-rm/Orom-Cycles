//
//  ScannerView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 14/07/23.
//

import SwiftUI
import CodeScanner
import AVFoundation

struct ScannerView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @EnvironmentObject var tripViewModel: TripViewModel
    
    @State var isTorchOn: Bool = false
    
    var body: some View {
        ZStack() {
            
            VStack {
                Button {
                    // Dissmiss view
                    isTorchOn = false
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
                
                Button {
                    // Toggle the flash light
                    isTorchOn.toggle()
                } label: {
                    Image(systemName: isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
                        .font(.system(size: 44))
                }
                .padding(.bottom, 100)
            }
            
            if checkCameraAccess(), dashboardViewModel.showScanner {
                CodeScannerView(codeTypes: [.qr], simulatedData: "64885b58d383a32d308f5c9c\nCycle 7", isTorchOn: isTorchOn, completion: handleScan)
                    .cornerRadius(2)
                    .background(
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                    )
                    .padding(.horizontal, 45)
                    .frame(height: UIScreen.main.bounds.width - 90)
            } else {
                SheetAlertView(.other, imageSystemName: "camera", text: "Camera access has been denied, enable camera access from settings")
            }
        }
    }
    
    /// - This function handles the result after scanning
    /// - It's the completion handler for CodeScannerView
    func handleScan(result: Result<ScanResult, ScanError>) {
        isTorchOn = false
        dashboardViewModel.toggleShowScanner()
        
        switch result {
        case .success(let scanResult):
            // Scanning the QR code returns two lines of string the 1st line contains the cycle number, the second line contains the cycle name
            let cycleIdAndName = scanResult.string.split(separator: "\n")
            tripViewModel.cycleId = String(cycleIdAndName[0])
            tripViewModel.cycleName = String(cycleIdAndName[1])
            dashboardViewModel.toggleShowStartRide()
        case .failure(let error):
            print("DEBUG: Scanning failed with error \(error.localizedDescription)")
        }
    }
}



extension ScannerView {
    
    func checkCameraAccess() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .restricted:
            print("DEBUG: Device Owner must approve")
            return false
        case .denied:
            print("DEBUG: Enable camera access from settings")
            return false
        case .notDetermined:
            return false
        default:
            print("DEBUG: unknown camera access error before scanning")
            return false
        }
    }
}



struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
            .environmentObject(DashboardViewModel())
            .environmentObject(TripViewModel())
    }
}
