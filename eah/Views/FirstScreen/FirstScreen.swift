import SwiftUI

struct FirstScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                
                ZStack {
                    Spacer()
                   // Text("Популярное").font(Font.custom("Manrope-Regular", size: 20)).fontWeight(.semibold)
                    Text("Популярное")
                        .fontWeight(.semibold)
          

                    Spacer()
                    
                    NavigationLink(
                        destination: ListOfMeals(searchStatus: true, items: viewModel.allItems),
                        label: {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                                .background(Color(UIColor.systemGray).opacity(0.12))
                                .foregroundColor(.black)
                                .cornerRadius(9.5)
                        })
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                
                
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 7.0){
                        Text("Привет Данил")
                          //  .font(Font.custom("Manrope-Regular", size: 20)).
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("mainColor"))
                        
                        Text("Хочешь приготовить что-нибудь?")
                        //    .font(Font.custom("Manrope-Regular", size: 20)).fontWeight(.bold)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        
                    }.padding()
                    
                    HStack{
                        
                        Text("Рекомендации")
                            .fontWeight(.semibold)
                        Spacer()
                        
                        
                        NavigationLink(destination: ListOfMeals(items: viewModel.recomendationItems)){
                            Text("Посмотреть все")
                                //.font(Font.custom("Manrope-Regular", size: 16))
                                .foregroundColor(Color("mainColor"))
                        }
                        
                        
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 16){
                            ForEach(viewModel.recomendationItems){
                                item in
                                NavigationLink(
                                    destination: MealView(item: item, fromMealPlanner: false),
                                    label: {
                                        RecomendationRecipe(item: item)
                                    }
                                )
                                
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })
                    
                    
                    
                    HStack{
                        Text("Популярное")
                          //  .font(Font.custom("Manrope-Regular", size: 16))
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        Spacer()
                        
                        NavigationLink(destination: ListOfMeals(items: viewModel.popular)){
                            Text("Посмотреть все")
                                //.font(Font.custom("Manrope-Regular", size: 16))
                                .font(.system(size: 16))
                                .foregroundColor(Color("mainColor"))
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
                    
                    
                    
                    //                    if (viewModel.breakfast + viewModel.lunch + viewModel.dinner).count != 0 {
                    
                    HStack{
                        Text("Ваш план питания")
                            //.font(Font.custom("Manrope-Regular", size: 16))
                            .fontWeight(.semibold)
                            .font(.system(size: 16))

                        Spacer()
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 16){
                            ForEach(viewModel.week){
                                item in
                                Button(action: {                                withAnimation(.spring()){
                                    viewModel.selectedDay = item
                                }}, label: {
                                    Text(item.russianName.prefix(3))
                                    //    .font(Font.custom("Manrope-Regular", size: 16)).fontWeight(.bold)
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(viewModel.selectedDay.id == item.id ? Color("mainColor") : .gray)
                                    
                                    
                                }).padding(.vertical, 9)
                                .padding(.horizontal)
                                .background(viewModel.selectedDay.id == item.id ? Color("backColor") : Color(UIColor.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                        
                        
                    }).padding()
                    
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 16){
                            
                            if (viewModel.breakfast + viewModel.lunch + viewModel.dinner).count != 0 {
                                ForEach(viewModel.breakfast){
                                    item in
                                    
                                    NavigationLink(
                                        destination: MealView(item: item, fromMealPlanner: false),
                                        label: {
                                            MealPlanner(item: item, time: "Breakfast")
                                        }
                                    )
                                }
                                
                                ForEach(viewModel.lunch){
                                    item in
                                    
                                    NavigationLink(
                                        destination: MealView(item: item, fromMealPlanner: false),
                                        label: {
                                            MealPlanner(item: item, time: "Lunch")
                                        }
                                    )
                                }
                                
                                
                                ForEach(viewModel.dinner){
                                    item in
                                    
                                    NavigationLink(
                                        destination: MealView(item: item, fromMealPlanner: false),
                                        label: {
                                            MealPlanner(item: item, time: "Dinner")
                                        }
                                    )
                                }
                            }
                        }
                    }).padding(.leading).padding(.bottom).padding(.trailing)
                }
                )
                
            }.navigationBarHidden(true)
        
            
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen().environmentObject(ContentViewModel())
    }
}

