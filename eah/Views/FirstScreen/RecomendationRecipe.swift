import SwiftUI

struct RecomendationRecipe: View {
    var item: Meal
    
    var body: some View {

        VStack{
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom), content: {
                
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 140, alignment: .center)
                    .cornerRadius(10)
                
                Text(item.time)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                    .padding(.leading,0)
                    .background(Color(red: 1, green: 1, blue: 1, opacity: 0.5))
                    .cornerRadius(10, corners: [.bottomLeft, .topRight])
                    .font(.system(size: 11, weight: .medium, design: .default))
            })
            
            Text(item.name)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor.black))
                
            HStack{
            
                Star(star: item.star)
                
                Spacer()
                
                Text(item.type)
                    .font(.system(size: 12, weight: .light, design: .default))
                    .foregroundColor(Color(UIColor.systemGray))
            }
        }.padding(.all,8).padding(.bottom, 10)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
    }
    
}

struct Recomendation_Recipe_Previews: PreviewProvider {
    static var previews: some View {
      //  FirstScreen().environmentObject(ContentViewModel())
        RecomendationRecipe(item: ContentViewModel().recomendationItems[0])
    }
    
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
