import SwiftUI

struct MainView: View {
    var body: some View {
        
        ZStack{
            
            //            let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "YourFontName", size: 12.0)!]
            //            UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
            //            //Set Tab bar text/item color
            //            UITabBar.appearance().tintColor = UIColor.init(named: "YourColorName")
            //
            
            UIKitTabView([
                UIKitTabView.Tab(
                    view: FirstScreen().edgesIgnoringSafeArea(.top),
                    barItem: UITabBarItem(title: "Рецепты", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
                )
                ,
                UIKitTabView.Tab(
                    view: SecondScreen().edgesIgnoringSafeArea(.top),
                    barItem: UITabBarItem(title: "План питания", image: UIImage(systemName: "menucard.fill"), selectedImage: UIImage(systemName: "menucard.fill"))
                ),
                UIKitTabView.Tab(
                    view: ThirdScreen().edgesIgnoringSafeArea(.top),
                    barItem: UITabBarItem(title: "Поиск", image: UIImage(systemName: "fork.knife"), selectedImage: UIImage(systemName: "fork.knife"))
                ),
                UIKitTabView.Tab(
                    view: FourthScreen().edgesIgnoringSafeArea(.top),
                    barItem: UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart.fill"), selectedImage: UIImage(systemName: "cart.fill"))
                ),
                UIKitTabView.Tab(
                    view: FifthScreen().edgesIgnoringSafeArea(.top),
                    barItem: UITabBarItem(title: "Аккаунт", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle"))
                ),
            ])
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ContentViewModel())
    }
}


