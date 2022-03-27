import SwiftUI

struct MainView: View {
    private var secondTabImage = UIImage(systemName: "magnifyingglass")
    private var thirdTabImage = UIImage(systemName: "list.bullet.rectangle")
    
    init() {
        if #available(iOS 15.0, *) {
            secondTabImage = UIImage(systemName: "menucard.fill")
            thirdTabImage = UIImage(systemName: "fork.knife")
        }
    }
    
    var body: some View {
        ZStack{
            UIKitTabView([
                UIKitTabView.Tab(
                    view: FirstScreen().edgesIgnoringSafeArea(.top),
                    barItem: UITabBarItem(title: "Рецепты", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
                ),
                UIKitTabView.Tab(
                    view: SecondScreen().edgesIgnoringSafeArea(.top),
                    barItem: UITabBarItem(title: "План питания", image: secondTabImage, selectedImage: secondTabImage)
                ),
                UIKitTabView.Tab(
                    view: ThirdScreen().edgesIgnoringSafeArea(.top),
                    barItem: UITabBarItem(title: "Поиск", image: thirdTabImage, selectedImage: thirdTabImage)
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


