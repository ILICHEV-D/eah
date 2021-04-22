import SwiftUI

struct ForMealPlannerBlock: View {
    var item: Meal
    
    var body: some View {
        HStack(spacing: 15){
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.all, 8)
                .background(Color("breakfastColor"))
                .frame(width: 75, height: 75, alignment: .center)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name).font(.system(size: 14))
                    .foregroundColor(Color(UIColor.black))
                Text("🔥 \(item.calories ?? 0) calories").font(.system(size: 12))
                    .foregroundColor(Color(UIColor.black))
                Text(item.time).font(.system(size: 11))
                    .foregroundColor(Color(UIColor.black))
                
            }
            
        }.frame(width: 230, height: 100, alignment: .leading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
        .padding(.bottom)
        
    }
}
//                .frame(width: 230, height: 100, alignment: .leading)
//                .padding(.leading)
//                .background(Color.white)
//                .cornerRadius(16)
//                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
//                .padding(.bottom)
                

struct ForMealPlannerBlock_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen()
    }
}
