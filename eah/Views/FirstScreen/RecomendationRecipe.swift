import SwiftUI

struct RecomendationRecipe: View {
    var item: Meal
    
    var body: some View {
        VStack{
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom), content: {
                    
                    ArticleImage(imageLoader: ImageLoaderCache.shared.loaderFor(article: item))
                        .frame(width: 140, height: 140)
                        .cornerRadius(8)
                    
                    Text(item.stringTime ?? "")
                        .foregroundColor(.black)
                        .padding(.vertical, 8).padding(.horizontal, 8).padding(.leading, 0)
                        .background(Color(red: 1, green: 1, blue: 1, opacity: 0.7))
                        .cornerRadius(8, corners: [.bottomLeft, .topRight])
                        .font(Font.system(size: 11))
                })
                
                Image("povarenok")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20, alignment: .center)
                    .cornerRadius(6, corners: [.bottomRight, .topLeft])
            })
            
            HStack {
                Text(item.name)
                    .font(.system(size: 14))
                    .foregroundColor(Color(UIColor.black))
                    .multilineTextAlignment(.leading)
                    .frame(width: 130, height: 35)
                    .lineLimit(2)
                Spacer()
            }
            
            HStack{
                Star(star: item.star)
                Spacer()
                Text(item.type ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(Color(UIColor.systemGray))
                    .fontWeight(.medium)
            }
        }.padding(.all)
            .frame(height: 250, alignment: .center)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
    }
    
}

struct Recomendation_Recipe_Previews: PreviewProvider {
    static var previews: some View {
        RecomendationRecipe(item: ContentViewModel().recomendationItems[0])
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
