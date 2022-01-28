import SwiftUI

struct ForMealPlannerBlock: View {
    var item: Meal
    var color: String
    
    var body: some View {
        HStack(spacing: 15){
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                ArticleImage(imageLoader: ImageLoaderCache.shared.loaderFor(
                    article: item))
                    .frame(width: 55, height: 55, alignment: .center)
                    .cornerRadius(14)
                    .aspectRatio(contentMode: .fill)
                    .padding(.all, 8)
                    .background(Color(color))
                    .cornerRadius(16)
                    .padding(.leading, 12)
                
                Image("povarenok")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 15, height: 15, alignment: .center)
                    .cornerRadius(8)
                    .padding(.trailing, 5)
                    .padding(.bottom, 5)
            })
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name).font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor.black))
                    .multilineTextAlignment(.leading)
                Text("🔥 \(Int(item.ePower?.calories ?? 0)) калорий").font(.system(size: 12))
                    .foregroundColor(Color(UIColor.black))
                Text(String(item.stringTime ?? ""))
                    .font(.system(size: 11))
                    .foregroundColor(Color(UIColor.black))
            }
            
        }.frame(width: 230, height: 100, alignment: .leading)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
            .padding(.bottom)
    }
}

struct ForMealPlannerBlock_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen()
    }
}
