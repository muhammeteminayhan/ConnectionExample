//
//  NetworkManager.swift
//  ConnectionExample
//
//  Created by Muhammet Emin Ayhan on 7.12.2024.
//

import Foundation
import Network
import SwiftUI

class NetworkManager: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue
    
    @Published var isConnected: Bool = true
    @Published var connectionDescription: String = "You are connected to the internet."
    @Published var imageName: String = "wifi"
    
    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue(label: "NetworkMonitorQueue")
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.isConnected = true
                    self.connectionDescription = "You are connected to the internet."
                    self.imageName = "wifi"
                } else {
                    self.isConnected = false
                    self.connectionDescription = "No internet connection."
                    self.imageName = "wifi.exclamationmark"
                }
            }
        }
        
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
