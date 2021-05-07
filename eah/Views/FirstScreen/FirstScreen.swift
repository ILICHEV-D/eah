import SwiftUI

struct FirstScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                ZStack {
                    
                    Spacer()
                    Text("Popular").fontWeight(.semibold)
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
                        Text("Hello Danil")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(Color("mainColor"))
                        
                        Text("Wanna make some delicious food?")
                            .font(.system(size: 20))
                    }.padding()
                    
                    HStack{
                        
                        Text("Recomendation Recipe").font(.system(size: 18)).fontWeight(.semibold)
                        
                        Spacer()
                        
                        
                        NavigationLink(destination: ListOfMeals(items: viewModel.recomendationItems)){
                            Text("See all").font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(Color("mainColor"))
                        }
                        
                        
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 16){
                            ForEach(viewModel.recomendationItems){
                                item in
                                NavigationLink(
                                    destination: MealView(item: item),
                                    label: {
                                        RecomendationRecipe(item: item)
                                    }
                                )
                                
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })
                    
                    
                    
                    HStack{
                        Text("Popular").font(.system(size: 18)).fontWeight(.semibold)
                        Spacer()
                        
                        NavigationLink(destination: ListOfMeals(items: viewModel.popular)){
                            Text("See all").font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(Color("mainColor"))
                        }
                        
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 16){
                            ForEach(viewModel.popular){
                                item in
                                NavigationLink(
                                    destination: MealView(item: item),
                                    label: {
                                        Popular(item: item)
                                    }
                                )
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })
                    
                    
                    
                    //                    if (viewModel.breakfast + viewModel.lunch + viewModel.dinner).count != 0 {
                    
                    HStack{
                        Text("Your Meal Planner").font(.system(size: 18)).fontWeight(.semibold)
                        Spacer()
                    }.padding(.trailing).padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 16){
                            ForEach(viewModel.week){
                                item in
                                Button(action: {                                withAnimation(.spring()){
                                    viewModel.selectedDay = item
                                }}, label: {
                                    Text(item.name.prefix(3))
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
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
                                        destination: MealView(item: item),
                                        label: {
                                            MealPlanner(item: item, time: "Breakfast")
                                        }
                                    )
                                }
                                
                                ForEach(viewModel.lunch){
                                    item in
                                    
                                    NavigationLink(
                                        destination: MealView(item: item),
                                        label: {
                                            MealPlanner(item: item, time: "Lunch")
                                        }
                                    )
                                }
                                
                                ForEach(viewModel.dinner){
                                    item in
                                    
                                    NavigationLink(
                                        destination: MealView(item: item),
                                        label: {
                                            MealPlanner(item: item, time: "Dinner")
                                        }
                                    )
                                }
                                //                            }
                                //                            else {
                                //                                Button(action: {
                                //
                                //                                }) {
                                //                                    HStack(spacing: 20) {
                                //                                        Image("Component1")
                                //                                        VStack(alignment: .leading, spacing: 5) {
                                //                                            Image("rectangle3")
                                //                                            Image("rectangle2")
                                //                                            Image("rectangle1")
                                //                                        }
                                //                                        Spacer()
                                //                                    }.padding()
                                //                                }
                                //           }
                            }
                        }
                    }).padding(.leading).padding(.bottom).padding(.trailing)
                }
                )
                
            }.navigationBarHidden(true)
            //
            //            .navigationBarItems(leading:
            //                                    Image(systemName: "list.bullet")
            //                                    .font(.title2)
            //                                    .frame(width: 35, height: 35, alignment: .center).cornerRadius(9.5)
            //                                    .background(Color(UIColor.systemGray).opacity(0.12))
            //                                    .foregroundColor(.black)
            //                                    .cornerRadius(9.5)
            //                                , trailing:
            //                                    Button(action: {}, label: {
            //                                        Image(systemName: "magnifyingglass")
            //                                            .font(.title2)
            //                                            .frame(width: 35, height: 35, alignment: .center).cornerRadius(9.5)
            //                                            .background(Color(UIColor.systemGray).opacity(0.12))
            //                                            .foregroundColor(.black)
            //                                    }).cornerRadius(9.5)
            //            )
            //            .navigationBarTitle("Popular")
            //            .navigationBarTitleDisplayMode(.inline)
            //
            
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen().environmentObject(ContentViewModel())
    }
}

