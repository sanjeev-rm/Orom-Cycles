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
    
    @State var isFlashlightOn: Bool = false
    
    var body: some View {
        ZStack() {
            
            VStack {
                Button {
                    // Dissmiss view
                    isFlashlightOn = false
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
                
                if checkCameraAccess() {
                    Button {
                        // Toggle the flash light
                        withAnimation { isFlashlightOn.toggle() }
                    } label: {
                        if isFlashlightOn {
                            flashlightOnSymbol
                        } else {
                            flashlightOffSymbol
                        }
                    }
                    .padding(.bottom, 100)
                    .foregroundColor(.primary)
                }
            }
            
            ZStack {
                if checkCameraAccess(), dashboardViewModel.showScanner {
                    CodeScannerView(codeTypes: [.qr], showViewfinder: false, simulatedData: "orom-cycle\n64e73cc46f9398677838051f\nCycle 16", isTorchOn: isFlashlightOn, completion: handleScan)
                } else {
                    SheetAlertView(.other, imageSystemName: "camera", text: "Camera access has been denied, enable camera access from settings")
                        .frame(height: UIScreen.main.bounds.width - 90)
                }
            }
            .cornerRadius(2)
            .background(
                RoundedRectangle(cornerRadius: 2, style: .circular)
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
            )
            .padding(.horizontal, 45)
            .frame(height: UIScreen.main.bounds.width - 90)
        }
    }
    
    /// - This function handles the result after scanning
    /// - It's the completion handler for CodeScannerView
    func handleScan(result: Result<ScanResult, ScanError>) {
        isFlashlightOn = false
        dashboardViewModel.toggleShowScanner()
        
        switch result {
        case .success(let scanResult):
            // Scanning the QR code returns three lines of string the 1st line contains the string 'orom-cycle', the second line contains the cycle Id, and the third line contains the cycle name
            /*
             orom-cycle
             64e73cc46f9398677838051f
             Cycle 16
             */
            let cycleIdAndName = scanResult.string.split(separator: "\n")
            // High level of verification
            if cycleIdAndName.count == 3,
               String(cycleIdAndName[0]) == "orom-cycle" {
                tripViewModel.cycleId = String(cycleIdAndName[1])
                tripViewModel.cycleName = String(cycleIdAndName[2])
                dashboardViewModel.toggleShowStartRide()
            } else {
                print("DEBUG: Wrong QR CODE")
                dashboardViewModel.toggleShowInvalidQRCodeMessage()
            }
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



extension ScannerView {
    
    private var flashlightOnSymbol: some View {
        ZStack {
            Circle()
                .frame(width: 80)
                .foregroundColor(.gray.opacity(0.3))
            Image(systemName: "flashlight.on.fill")
                .font(.system(size: 40))
        }
    }
    
    private var flashlightOffSymbol: some View {
        ZStack {
            Circle()
                .frame(width: 80)
                .foregroundColor(.clear)
            Image(systemName: "flashlight.off.fill")
                .font(.system(size: 40))
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
