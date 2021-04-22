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
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewModel)
        }
    }
}
