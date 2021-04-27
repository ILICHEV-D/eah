import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            FirstScreen()
                
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
               //     Label("Popular", systemImage: "list.dash")
                }
            SecondScreen()
                .tabItem {
                    Image(systemName: "doc.text.fill")
            }
            ThirdScreen()
                .tabItem {
                    Image(systemName: "bag.fill")
            }
            FourthScreen()
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2.fill")
            }
            FifthScreen()
                .tabItem {
                    Image(systemName: "person.fill")
            }
            
        }.accentColor(Color("mainColor"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ContentViewModel())
    }
}
