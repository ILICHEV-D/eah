//
//  eahApp.swift
//  eah
//
//  Created by Danil Ilichev on 22.04.2021.
//

import SwiftUI

@main
struct eahApp: App {
    @StateObject var viewModel = ContentViewModel()
    @Environment(\.scenePhase) var scenePhase

    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewModel)
        }.onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                viewModel.saveData()
                print("Scene is in background")
            case .inactive:
                viewModel.saveData()
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Some strange problem")
            }
        }
    }
}
