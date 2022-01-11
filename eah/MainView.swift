import SwiftUI

struct MainView: View {
    var body: some View {

        TabView {
            FirstScreen()
                .tabItem {
                    Label("Рецепты", systemImage: "house")
                }
            
            SecondScreen()
                .tabItem {
                    Label("План питания", systemImage: "menucard")
                }
            
            ThirdScreen()
                .tabItem {
                    Label("Поиск", systemImage: "fork.knife")
                }
            FourthScreen()
                .tabItem {
                    Label("Корзина", systemImage: "cart")
                }
            FifthScreen()
                .tabItem {
                    Label("Аккаунт", systemImage: "person.crop.circle")
                }
        }
        .accentColor(Color("mainColor"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ContentViewModel())
    }
}


