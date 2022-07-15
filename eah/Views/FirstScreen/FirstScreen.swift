import SwiftUI
import Combine

struct FirstScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView{
            
            VStack {
                
                // MARK: - Navigation Bar
                
                ZStack {
                    Spacer()
                    Text("Популярное").fontWeight(.semibold)
                    Spacer()
                    
                    NavigationLink(destination: ListOfMeals(searchStatus: true, items: viewModel.searchItems, index: 3), tag: 0, selection: $selection)
                    {
                        Button(action: {
                            self.selection = 0
                        }) {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                                .background(Color(UIColor.systemGray).opacity(0.12))
                                .foregroundColor(.black)
                                .cornerRadius(9.5)
                        }
                    }
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                // MARK: - Main code
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 7.0){
                        Text(viewModel.userName != "" ? "Привет, \(viewModel.userName)" : "Привет")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("mainColor"))
                        Text("Хочешь что-нибудь приготовить?")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                    }.font(.system(size: 20)).padding()
                    
                    // MARK: Recommnedation
                    
                    HStack{
                        Text("Рекомендованные рецепты")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        NavigationLink(destination: ListOfMeals(items: viewModel.recomendationItems, index: 1), tag: 1, selection: $selection) {
                            Button(action: {
                                self.selection = 1
                            }) {
                                Text("Все")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("mainColor"))
                                    .font(.system(size: 12))
                            }
                        }
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 16){
                            if viewModel.recomendationItems.count != 0 {
                                ForEach(viewModel.recomendationItems){
                                    item in
                                    NavigationLink(
                                        destination: MealView(item: item, fromMealPlanner: false),
                                        label: {
                                            RecomendationRecipe(item: item)
                                        }
                                    )
                                }
                            } else {
                                ForEach(viewModel.allMeals){
                                    item in
                                    NavigationLink(
                                        destination: MealView(item: item, fromMealPlanner: false),
                                        label: {
                                            RecomendationRecipe(item: item)
                                        }
                                    )
                                }
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })
                    
                    // MARK: Popular
                    
                    HStack{
                        Text("Популярное")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        NavigationLink(destination: ListOfMeals(items: viewModel.popular, index: 2), tag: 2, selection: $selection) {
                            Button(action: {
                                self.selection = 2
                            }) {
                                Text("Все")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("mainColor"))
                                    .font(.system(size: 12))
                            }
                        }
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 16){
                            ForEach(viewModel.popular){
                                item in
                                NavigationLink(
                                    destination: MealView(item: item, fromMealPlanner: false),
                                    label: {
                                        Popular(item: item)
                                    }
                                )
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })
                    
                    
                    // MARK: First category
                    
                    HStack{
                        Text("Салаты")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        NavigationLink(destination: ListOfMeals(items: viewModel.firstCategory), tag: 3, selection: $selection) {
                            Button(action: {
                                self.selection = 3
                            }) {
                                Text("Все")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("mainColor"))
                                    .font(.system(size: 12))
                            }
                        }
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 16){
                            ForEach(viewModel.firstCategory){
                                item in
                                NavigationLink(
                                    destination: MealView(item: item, fromMealPlanner: false),
                                    label: {
                                        Popular(item: item)
                                    }
                                )
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })
                    
                    
                    // MARK: Second category
                    
                    HStack{
                        Text("Десерты")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        NavigationLink(destination: ListOfMeals(items: viewModel.secondCategory), tag: 4, selection: $selection) {
                            Button(action: {
                                self.selection = 4
                            }) {
                                Text("Все")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("mainColor"))
                                    .font(.system(size: 12))
                            }
                        }
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 16){
                            ForEach(viewModel.secondCategory){
                                item in
                                NavigationLink(
                                    destination: MealView(item: item, fromMealPlanner: false),
                                    label: {
                                        Popular(item: item)
                                    }
                                )
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })
                    
                    // MARK: Third category
                    
                    VStack {
                        HStack{
                            Text("Супы")
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                            
                            Spacer()
                            
                            NavigationLink(destination: ListOfMeals(items: viewModel.thirdCategory), tag: 4, selection: $selection) {
                                Button(action: {
                                    self.selection = 4
                                }) {
                                    Text("Все")
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("mainColor"))
                                        .font(.system(size: 12))
                                }
                            }
                        }.padding(.trailing).padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            HStack(spacing: 16){
                                ForEach(viewModel.thirdCategory){
                                    item in
                                    NavigationLink(
                                        destination: MealView(item: item, fromMealPlanner: false),
                                        label: {
                                            Popular(item: item)
                                        }
                                    )
                                }
                            }.padding(.leading).padding(.bottom).padding(.trailing)
                        })
                    }
                    
                })
            }.navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen().environmentObject(ContentViewModel())
    }
}
