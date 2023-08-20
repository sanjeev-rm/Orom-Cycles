//
//  NetworkMonitor.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 21/08/23.
//

import Foundation
import Network

/// Class Monitors the network of the device continuously
class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false {
        didSet {
            isNotConnected = !isConnected
        }
    }
    
    var isNotConnected = true

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
