import SwiftUI

struct ListOfMeals: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    
    @State var searchQuery = ""
    @State var searchStatus = false
    
    
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    var items: [Meal]
    var index: Int?
    
    var check: String?
    
    @State var selection: Int? = nil
    
    
    
    var body: some View {
        
        VStack {
            // MARK: - NavBar
            
            if searchStatus == false {
                HStack {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                            .background(Color(UIColor.systemGray).opacity(0.12))
                            .foregroundColor(.black)
                    }).cornerRadius(9.5)
                    Spacer()
                    Text("Рецепты").fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        searchStatus = true
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                            .background(Color(UIColor.systemGray).opacity(0.12))
                            .foregroundColor(.black)
                    }).cornerRadius(9.5)
                }.ignoresSafeArea().padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
            } else {
                
                HStack {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                            .background(Color(UIColor.systemGray).opacity(0.12))
                            .foregroundColor(.black)
                    }).cornerRadius(9.5)
                    Spacer()
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.gray)
                        
                        TextField("Поиск", text: $searchQuery.onChange({ someText in
                            viewModel.searchName = someText
                        }), onCommit:  {
                            UIApplication.shared.endEditing()
                        })}
                    .frame(height: 20)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.05))
                    .cornerRadius(8)
                    
                    Button(action: {
                        searchStatus = false
                        searchQuery = ""
                        viewModel.searchName = ""
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                            .background(Color(UIColor.systemGray).opacity(0.12))
                            .foregroundColor(.black)
                    }).cornerRadius(9.5)
                }
                .padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
            }
            
            // MARK: - MainCode
            
            ScrollView(.vertical, showsIndicators: true, content: {
                LazyVGrid(columns: columns, content: {
                    
                    ForEach(searchQuery == "" ? items : viewModel.searchItems){
                        item in
                        if check == nil {
                            NavigationLink(
                                destination: MealView(item: item, fromMealPlanner: false),
                                label: {
                                    RecomendationRecipe(item: item).gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                                        if(value.startLocation.x < 60 && value.translation.width > 20) {
                                            self.mode.wrappedValue.dismiss()
                                        }
                                    }))
                                }
                            )
                        }
                        
                        else {
                            Button(action: {
                                var meal: Meal?
                                
                                if let index = viewModel.allItems.firstIndex(where: { $0.id == item.id }) {
                                    meal = viewModel.allItems[index]
                                } else {
                                    meal = item
                                }
                                meal!.dayOfWeek = DayOfWeek(date: Date().getWeekDate(week: viewModel.selectedDay.name), time: check!)
                                viewModel.mealPlannerItems.append(meal!)
                                viewModel.selectedDay = viewModel.selectedDay //!!!
                                presentationMode.wrappedValue.dismiss()}) {
                                    RecomendationRecipe(item: item).gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                                        if(value.startLocation.x < 60 && value.translation.width > 20) {
                                            self.mode.wrappedValue.dismiss()
                                        }
                                    }))
                                }
                        }
                    }
                    Rectangle()
                        .foregroundColor(.white)
                        .onAppear {
                            print("Reached end of scroll view")
                            guard let ind = index else {return}
                            guard searchQuery == "" else {return}
                            if ind == 0 {
                                viewModel.allItemsLimit += 10
                                viewModel.endpoint0 = Endpoint(index: 0, limit: viewModel.allItemsLimit)!
                            } else if ind == 1 {
                                viewModel.recomendationLimit += 10
                                viewModel.endpoint1 = Endpoint(index: 1, limit: viewModel.recomendationLimit)!
                            } else if ind == 2 {
                                viewModel.popularLimit += 10
                                viewModel.endpoint2 = Endpoint(index: 2, limit: viewModel.popularLimit)!
                            } else if ind == 6 {
                                viewModel.mealWithIngredientsLimit += 10
                                viewModel.endpoint6 = Endpoint(index: 6, limit: viewModel.mealWithIngredientsLimit)!
                            }
                            
                        }
                }).padding(.horizontal).padding(.vertical)
            })
        }.gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 60 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        })).navigationBarHidden(true)
    }
}

struct ListOfMeals_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMeals(items: ContentViewModel().allItems)
    }
}
