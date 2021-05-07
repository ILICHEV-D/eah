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
    var check: String?
    
    
    
    
    var body: some View {
        
        VStack {
            
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
                Text("Meals").fontWeight(.semibold)
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
            }
            
            
            else {
            
            HStack {
                HStack{
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchQuery, onCommit:  {
                        UIApplication.shared.endEditing()
                    })
                }
                .frame(height: 20)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(8)
                
                Button(action: {
                    searchStatus = false
                    searchQuery = ""
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
            
            
            //       NavigationView {
            
            
            ScrollView(.vertical, showsIndicators: true, content: {
                LazyVGrid(columns: columns, content: {
                    
                    ForEach(searchQuery == "" ? items :
                                items.filter{$0.name.lowercased().contains(searchQuery.lowercased())}
                    ){
                        item in
                        if check == nil {
                            
                            NavigationLink(
                                destination: MealView(item: item),
                                label: {
                                    RecomendationRecipe(item: item).gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                                        if(value.startLocation.x < 60 && value.translation.width > 20) {
                                            self.mode.wrappedValue.dismiss()
                                        }
                                    }))
                                }
                            )
                        }
                        
                        else { //!!!
                            Button(action: {
                                    
                                    viewModel.allItems[viewModel.allItems.firstIndex(where: { $0.id == item.id })!].dayOfWeek.append(DayOfWeek(week: viewModel.selectedDay, foodIntake: check!))
                                    presentationMode.wrappedValue.dismiss()}) {
                                RecomendationRecipe(item: item).gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                                    if(value.startLocation.x < 60 && value.translation.width > 20) {
                                        self.mode.wrappedValue.dismiss()
                                    }
                                }))
                            }
                        }
                    }
                })
                .padding(.horizontal).padding(.vertical)
            })
            
            
            
        }.gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 60 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        })).navigationBarHidden(true)
      //  .edgesIgnoringSafeArea(.top)

        
    }
    
    
}

struct ListOfMeals_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMeals(items: ContentViewModel().allItems)
    }
}

