import SwiftUI

struct SecondScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State var showView = false
    
    var body: some View {
        
        NavigationView{
            
            
            VStack{
                HStack {
                    Spacer()
                    Text("Meal Planner").fontWeight(.semibold)
                    Spacer()
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                
                ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                    VStack{
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            
                            HStack(spacing: 16){
                                ForEach(viewModel.week){
                                    item in
                                    Button(action: {
                                            withAnimation(.spring()){
                                                viewModel.selectedDay = item
                                            }}, label: {
                                                Text(item.name.prefix(3))
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
                        
                        HStack{
                            Text("For Breakfast").font(.system(size: 18)).fontWeight(.semibold)
                            Spacer()
                            NavigationLink(
                                destination: ListOfMeals(items: viewModel.allItems, check: "breakfast"),
                                label: {
                                    Text("Add more")
                                        .foregroundColor(Color("mainColor"))
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                    
                                }
                            )
                        }.padding(.trailing).padding(.top).padding(.leading)
                        
                        
                        //         if viewModel.breakfast.count != 0 {
                        if viewModel.breakfast.count != 0 {
                            
                            SecondScreenScroll(items: viewModel.breakfast, nameOfColor: "breakfastColor")      //!!!
                            
                        }
                        else {
                            NavigationLink(
                                destination: ListOfMeals(items: viewModel.allItems, check: "breakfast"),
                                label: {
                                    ForMealPlannerFreeBlock(color: "Component0").padding()
                                }
                            )
                        }
                        
                        
                        Divider()
                        
                        HStack{
                            Text("For Lunch").font(.system(size: 18)).fontWeight(.semibold)
                            Spacer()
                            NavigationLink(
                                destination: ListOfMeals(items: viewModel.allItems, check: "lunch"),
                                label: {
                                    Text("Add more")
                                        .foregroundColor(Color("mainColor"))
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                    
                                }
                            )
                        }.padding(.trailing).padding(.leading)
                        
                        //     if viewModel.lunch.count != 0 {
                        if viewModel.lunch.count != 0 {
                            
                            SecondScreenScroll(items: viewModel.lunch, nameOfColor: "lunchColor")      //!!!
                            //               SecondScreenScroll(items: viewModel.lunch, nameOfColor: "lunchColor")
                        }
                        else {
                            NavigationLink(
                                destination: ListOfMeals(items: viewModel.allItems, check: "lunch"),
                                label: {
                                    ForMealPlannerFreeBlock(color: "Component1").padding()
                                }
                            )
                        }
                        
                        Divider()
                        
                        HStack{
                            Text("For Dinner").font(.system(size: 18)).fontWeight(.semibold)
                            Spacer()
                            NavigationLink(
                                destination: ListOfMeals(items: viewModel.allItems, check: "dinner"),
                                label: {
                                    Text("Add more")
                                        .foregroundColor(Color("mainColor"))
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                    
                                }
                            )
                        }.padding(.trailing).padding(.leading)
                        
                        if viewModel.dinner.count != 0 {
                            
                            //             if viewModel.dinner.count != 0 {
                            SecondScreenScroll(items: viewModel.dinner, nameOfColor: "dinnerColor")      //!!!
                            
                            //             SecondScreenScroll(items: viewModel.dinner, nameOfColor: "dinnerColor")
                        }
                        else {
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
                        destination: MealView(item: item),
                        label: {
                            ForMealPlannerBlock(item: item, color: nameOfColor)
                        }
                    )
                    
                }
            }.padding(.leading).padding(.bottom).padding(.trailing)
        })
    }
}
