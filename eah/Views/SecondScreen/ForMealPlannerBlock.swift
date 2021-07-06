import SwiftUI

struct ForMealPlannerBlock: View {
    var item: Meal
    var color: String
    
    var body: some View {
        HStack(spacing: 15){
            Image(item.image)
                .resizable()
                .cornerRadius(14)
                .frame(width: 60, height: 60, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .padding(.all, 8)
                .background(Color(color))
                .cornerRadius(16)
                .padding(.leading, 12)

            
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
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
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
