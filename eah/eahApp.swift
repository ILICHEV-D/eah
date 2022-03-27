import SwiftUI
import UIKit
@main
struct eahApp: App {
    @StateObject var viewModel = ContentViewModel()
    @Environment(\.scenePhase) var scenePhase    
    
    init() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
        UITabBar.appearance().tintColor =  UIColor(named: "mainColor")
        UITabBar.appearance().isTranslucent = true
        
        AuthApi.loadToken()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewModel)
        }.onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                print("Scene is in background")
            case .inactive:
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Some strange problem")
            }
        }
    }
}
