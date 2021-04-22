import SwiftUI

struct SecondScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel

 //   @State var selectedDay: Week = week.first!

    var body: some View {
        
        NavigationView{
        
        VStack{
            Text("Meal-Planner").padding()
        
        ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
            VStack{
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
                
                HStack{
                    Text("For Breakfast").font(.system(size: 18))
                    Spacer()
                }.padding(.trailing).padding(.top).padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false, content: {

                    HStack(spacing: 16){
                        ForEach(viewModel.popular){
                            item in
                            NavigationLink(
                                destination: MealView(item: item),
                                label: {
                                    ForMealPlannerBlock(item: item).padding()
                                }
                            )

                        }
                    }.padding(.leading).padding(.bottom).padding(.trailing)
                })
                
                
                
                Divider()

                
                HStack{
                    Text("For Lunch").font(.system(size: 18))
                    Spacer()
                }.padding(.trailing).padding(.leading)
                
                ForMealPlannerFreeBlock(color: "Component1").padding()
                
                Divider()
                
                HStack{
                    Text("For Dinner").font(.system(size: 18))
                    Spacer()
                }.padding(.trailing).padding(.leading)
                
                ForMealPlannerFreeBlock(color: "Component2")
                    
                
            }
            
        })
        }.navigationBarHidden(true)
        }
    }
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen()
    }
}
