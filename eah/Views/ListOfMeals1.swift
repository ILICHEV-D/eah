import SwiftUI

struct ListOfMeals: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    var items: [Meal]
    
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: true, content: {
                LazyVGrid(columns: columns, content: {
                    
                    ForEach(items){
                        item in
                        RecomendationRecipe(item: item)
                    }.padding(.all, 8)
                })
                
            }
            
            ).navigationBarTitleDisplayMode(.inline).navigationBarHidden(true)
            
        }.navigationTitle("Meals")
        .navigationBarTitleDisplayMode(.inline)
        

    }
        
}

struct ListOfMeals_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
