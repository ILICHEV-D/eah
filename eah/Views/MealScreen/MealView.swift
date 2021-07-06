import SwiftUI

struct MealView: View {
    let item: Meal
    let fromMealPlanner: Bool
    
    @State private var selection = 0
    
    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var like = true
    @EnvironmentObject var viewModel: ContentViewModel
    



    var body: some View {
        
        VStack {

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

                
                
                Text("Калории  \(item.calories ?? 0) г 🔥").font(.system(size: 12))
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
                        Text("Белки").font(.system(size: 14))
                        Text("🍗 \(item.protein ?? 0) г").font(.system(size: 12)).foregroundColor(.gray)
                    }
                    
                    ChangeDivider()
                    
                    VStack(spacing: 7){
                        Text("Жиры").font(.system(size: 14))
                        Text("🍖 \(item.fat ?? 0) г").font(.system(size: 12)).foregroundColor(.gray)
                    }
                    
                    ChangeDivider()
                    
                    VStack(spacing: 7){
                        Text("Углеводы").font(.system(size: 14))
                        Text("🍞 \(item.protein ?? 0) г").font(.system(size: 12)).foregroundColor(.gray)
                    }
                    
                    
                }
                .frame(width: UIScreen.screenWidth - 60, height: 73, alignment: .center)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
                
                HStack{
                    VStack(alignment: .leading, spacing: 2) {
                    Text("Ингредиенты")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    
                    Text("\(item.ingridients?.count ?? 0) порций")
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
                
                HStack{
                    VStack(alignment: .leading, spacing: 2) {
                    Text("Рецепт")
                        .font(.system(size: 18))
                        .fontWeight(.bold)

                }
                    Spacer()
                }.padding(.leading).padding(.trailing)
                
                TabView(selection : $selection){
                    ForEach(0..<5){ i in
                        VStack(){
                            HStack(spacing: 16.0){
                                Text(String(selection + 1))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .background(Color("mainColor"))
                                    .cornerRadius(16)
                                    .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                Text("Порежьте ингредиенты")
                                    .fontWeight(.semibold)
                                Spacer()
                            }.padding(.bottom, 5)
                            Text("Isinya penjelasan tentang menjadi Chef setiap hari dan menjelaskan betapa mudahnya masak Chef setiap hari dan menjelaskan betapa mudahnya masak")
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                            
                            Image("stepRecipe")
                                .resizable()
                                .padding(.trailing, 5)
                        }
                    }
                }          //       .padding(.leading, -15).padding(.trailing, -15)

                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
              .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(height: 320)
                .padding()

            }.padding(.leading).padding(.trailing)
            

            
            
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
            


    }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView(item: ContentViewModel().allItems[0], fromMealPlanner: true)
//        FirstScreen().environmentObject(ContentViewModel())
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
