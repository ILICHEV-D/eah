import SwiftUI

struct MealView: View {
    let item: Meal

    var body: some View {
        
        
        ScrollView {
            VStack(){
                
                Image(item.image)
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding(.bottom, 15)
                
                Text(item.name)                        .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.bottom, 1)

                
                Text("Calories  \(item.calories ?? 0) 🔥").font(.system(size: 12))
                    .padding(.bottom, 23)

                
                Text(item.description ?? "")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                    
                
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
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                
                HStack{
                VStack(alignment: .leading) {
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
            
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
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
