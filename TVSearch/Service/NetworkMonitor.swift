//
//  NetworkMonitor.swift
//  TVSearch
//
//  Created by Tony Ayoub on 15-12-2024.
//

import Network
import Combine

class NetworkMonitor {
    let networkStatus = CurrentValueSubject<Bool, Never>(true)
    
    private let pathMonitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        pathMonitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.networkStatus.send(path.status == .satisfied)
        }
        pathMonitor.start(queue: monitorQueue)
    }
    
    deinit {
        pathMonitor.cancel()
    }
}
