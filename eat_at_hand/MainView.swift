import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            FirstScreen()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            SecondScreen()
                .tabItem {
                    Label("Order", systemImage: "cart.fill")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ContentViewModel())
    }
}
