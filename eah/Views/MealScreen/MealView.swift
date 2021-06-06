import SwiftUI

struct MealView: View {
    let item: Meal
    let fromMealPlanner: Bool
    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var like = true
    @EnvironmentObject var viewModel: ContentViewModel
    



    var body: some View {
        

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
            Text(item.name).fontWeight(.semibold)
            Spacer()
            
            if fromMealPlanner == true {
            
                
                Button(action: {
                    
                    let indexOfMeal = viewModel.allItems.firstIndex(where: { $0.id == item.id })!
                    let selectedD = viewModel.allItems[indexOfMeal].dayOfWeek.firstIndex(where: {$0.date == Date().getWeekDate(week: viewModel.selectedDay.name)})
                        
                    viewModel.allItems[indexOfMeal].dayOfWeek.remove(at: selectedD!)
                    self.mode.wrappedValue.dismiss()
                    
                }, label: {
                    Image(systemName: "trash")
                        .font(.title2)
                        .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                        .background(Color(UIColor.systemGray).opacity(0.12))
                        .foregroundColor(.black)
                    
                }).cornerRadius(9.5)
                
                
                
            }
            else {
            Button(action: {
                if let i  = viewModel.allItems.firstIndex(where: { $0.id == item.id }){
                    if viewModel.favoriteMeals.contains(item){
                        viewModel.allItems[i].favorites = false
                    }
                    else {
                        viewModel.allItems[i].favorites = true
                    }
                }
            }, label: {
                if viewModel.favoriteMeals.contains(item){
                    Image(systemName: "suit.heart.fill")
                        .font(.title2)
                        .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                        .background(Color(UIColor.systemGray).opacity(0.12))
                        .foregroundColor(.black)
                }
                else {
                
                Image(systemName: "suit.heart")
                    .font(.title2)
                    .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                    .background(Color(UIColor.systemGray).opacity(0.12))
                    .foregroundColor(.black)
                }
            }).cornerRadius(9.5)
            }


        }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
        
        
    //    NavigationView {
        ScrollView {
            VStack(){
                
                Image(item.image)
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)         .cornerRadius(15)
                    .padding(.bottom, 15)
                
                Text(item.name)                        .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.bottom, 1)

                
                Text("Calories  \(item.calories ?? 0) g 🔥").font(.system(size: 12))
                    .padding(.bottom, 20)

                
                Text("\" \(item.description ?? "") \"")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 15)
                    
                
                HStack(spacing: 20){
                    VStack(spacing: 7){
                        Text("Protein").font(.system(size: 14))
                        Text("🍗 \(item.protein ?? 0) g").font(.system(size: 12)).foregroundColor(.gray)
                    }
                    
                    ChangeDivider()
                    
                    VStack(spacing: 7){
                        Text("Fat").font(.system(size: 14))
                        Text("🍖 \(item.fat ?? 0) g").font(.system(size: 12)).foregroundColor(.gray)
                    }
                    
                    ChangeDivider()
                    
                    VStack(spacing: 7){
                        Text("Carbs").font(.system(size: 14))
                        Text("🍞 \(item.protein ?? 0) g").font(.system(size: 12)).foregroundColor(.gray)
                    }
                    
                    
                }
                .frame(width: UIScreen.screenWidth - 60, height: 73, alignment: .center)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
                
                HStack{
                    VStack(alignment: .leading, spacing: 2) {
                    Text("Ingredients")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    
                    Text("\(item.ingridients?.count ?? 0) items")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                    Spacer()
                }.padding()
                
                
                VStack(spacing: 16){
                    
                    ForEach(item.ingridients ?? [], id:\.self){
                        ingr in
                        IngridientView(item: convertIngridient(item: helpEnumIngredients.init(rawValue: ingr)!))
                    }
                }.padding(.leading).padding(.bottom).padding(.trailing)
                
            }.padding()
            
            
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
            
            
//        .navigationViewStyle(StackNavigationViewStyle())        .navigationBarTitle(item.name).navigationBarTitleDisplayMode(.inline)
//
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action : {
//            self.mode.wrappedValue.dismiss()
//        }){
//            Image(systemName: "chevron.left")
//                .frame(width: 32, height: 32, alignment: .center)
//                .background(Color(UIColor.systemGray).opacity(0.12))
//                .cornerRadius(9.5)
//                .foregroundColor(.black)
//        }
//        )
//        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
//            if(value.startLocation.x < 20 && value.translation.width > 100) {
//                self.mode.wrappedValue.dismiss()
//            }
//
//        }))
        }
        
        

//        .navigationViewStyle(StackNavigationViewStyle())
//        .navigationBarTitle(item.name).navigationBarTitleDisplayMode(.inline)
//
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action : {
//            self.mode.wrappedValue.dismiss()
//        }){
//            Image(systemName: "chevron.left")
//
//                .frame(width: 40, height: 40, alignment: .center)
//                .background(Color(UIColor.systemGray).opacity(0.12))
//                .cornerRadius(9.5)
//                .foregroundColor(.black)
//        }
//
//
//        ).edgesIgnoringSafeArea(.top)
//        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
//            if(value.startLocation.x < 20 && value.translation.width > 100) {
//                self.mode.wrappedValue.dismiss()
//            }
//
//        }))
        
        
        
        
  //  }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen().environmentObject(ContentViewModel())
    }
}


struct ChangeDivider: View {
    let color: Color = Color(UIColor.systemGray6)
    let width: CGFloat = 3
    let hight: CGFloat = 18
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: hight)
            .edgesIgnoringSafeArea(.vertical)
            .cornerRadius(1)
    }
}
