import SwiftUI

struct SecondScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    
    var body: some View {
        
        NavigationView{
            
            // MARK: - Navigation Bar
            
            VStack{
                HStack {
                    Spacer()
                    Text("Ваш план питания").fontWeight(.semibold)
                    Spacer()
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                // MARK: - MainCode
                
                // MARK: Days of week
                
                ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                    VStack{
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            
                            HStack(spacing: 16){
                                ForEach(viewModel.week){
                                    item in
                                    Button(action: {
                                        withAnimation(.spring()){
                                            viewModel.selectedDay = item
                                            viewModel.selectedDay = item
                                        }
                                        
                                    }, label: {
                                        Text(item.russianName.prefix(3))
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
                        
                        // MARK: Days
                        
                        MealAddMore(check: "breakfast", russianName: "Завтрак")
                        
                        if viewModel.breakfast.count != 0 {
                            SecondScreenScroll(items: viewModel.breakfast, nameOfColor: "breakfastColor")
                        } else {
                            NavigationLink(
                                destination: ListOfMeals(items: viewModel.allItems, check: "breakfast"),
                                label: {
                                    ForMealPlannerFreeBlock(color: "Component0").padding()
                                }
                            )
                        }
                        
                        Divider()
                        
                        MealAddMore(check: "lunch", russianName: "Обед")
                        
                        if viewModel.lunch.count != 0 {
                            SecondScreenScroll(items: viewModel.lunch, nameOfColor: "lunchColor")
                        } else {
                            NavigationLink(
                                destination: ListOfMeals(items: viewModel.allItems, check: "lunch"),
                                label: {
                                    ForMealPlannerFreeBlock(color: "Component1").padding()
                                }
                            )
                        }
                        
                        Divider()
                        
                        MealAddMore(check: "dinner", russianName: "Ужин")
                        
                        if viewModel.dinner.count != 0 {
                            SecondScreenScroll(items: viewModel.dinner, nameOfColor: "dinnerColor")
                        } else {
                            NavigationLink(
                                destination: ListOfMeals(items: viewModel.allItems, check: "dinner"),
                                label: {
                                    ForMealPlannerFreeBlock(color: "Component2").padding()
                                }
                            )
                        }
                    }
                })
            }.navigationBarHidden(true)
        }
    }
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen().environmentObject(ContentViewModel())
    }
}

struct SecondScreenScroll: View {
    var items: [Meal]
    var nameOfColor: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: 16){
                ForEach(items){
                    item in
                    NavigationLink(
                        destination: MealView(item: item, fromMealPlanner: true),
                        label: {
                            ForMealPlannerBlock(item: item, color: nameOfColor)
                        }
                    )
                    
                }
            }.padding(.leading).padding(.bottom).padding(.trailing)
        })
    }
}

struct MealAddMore: View {
    @EnvironmentObject var viewModel: ContentViewModel
    var check: String
    var russianName: String
    var body: some View {
        
        HStack{
            Text(russianName).font(.system(size: 18)).fontWeight(.semibold)
            Spacer()
            NavigationLink(
                destination: ListOfMeals(items: viewModel.allItems, check: check),
                label: {
                    Text("Добавить")
                        .foregroundColor(Color("mainColor"))
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                }
            )
        }.padding(.trailing).padding(.top).padding(.leading)
    }
}
