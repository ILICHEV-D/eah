//
//  eat_at_handApp.swift
//  eat_at_hand
//
//  Created by Danil Ilichev on 21.04.2021.
//

import SwiftUI

@main
struct eat_at_handApp: App {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewModel)
        }
    }
}
