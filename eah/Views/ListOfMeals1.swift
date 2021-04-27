import SwiftUI

struct ListOfMeals: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
 //   @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero

//    @Binding var navBarHidden : Bool

 //   @State private var showingDeleteAlert = false
    
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    var items: [Meal]
    var check: String?
    

    
    
    var body: some View {
        

        
        
 //       NavigationView {
            
            
            ScrollView(.vertical, showsIndicators: true, content: {
                LazyVGrid(columns: columns, content: {
                    
                    
                    ForEach(items){
                        item in
                        if check == nil {
                            
                            NavigationLink(
                                destination: MealView(item: item),
                                label: {
                                    RecomendationRecipe(item: item)
                                }
                            )
                        }
                        
                        else { //!!!
                            Button(action: {
                                    if check == "breakfast" {
                                        viewModel.breakfast.append(item)}
                                    else if check == "lunch" {
                                        viewModel.lunch.append(item)}
                                    else if check == "dinner" {
                                        viewModel.dinner.append(item)}
                                    
                                    presentationMode.wrappedValue.dismiss()}) {
                                RecomendationRecipe(item: item)
                            }
                        }
                        
                    }
                    
                })
                .padding(.horizontal).padding(.vertical)
                
            }
            
            
            )
            
            .navigationViewStyle(StackNavigationViewStyle())        .navigationBarTitle("Meals").navigationBarTitleDisplayMode(.inline)
            
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.left")
                    .frame(width: 32, height: 32, alignment: .center)
                    .background(Color(UIColor.systemGray).opacity(0.12))
                    .cornerRadius(9.5)
                    .foregroundColor(.black)
            }
            )
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.mode.wrappedValue.dismiss()
                }
                
            }))
        
        
        
    }
    

    
        
//        .navigationViewStyle(StackNavigationViewStyle())//        .navigationBarTitle("Meals").navigationBarTitleDisplayMode(.inline)
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
//        ).edgesIgnoringSafeArea(.top)
//        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
//            if(value.startLocation.x < 20 && value.translation.width > 100) {
//                self.mode.wrappedValue.dismiss()
//            }
//
//        }))
        


        
 //   }
    

        
}

struct ListOfMeals_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
