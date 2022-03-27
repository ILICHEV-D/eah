import SwiftUI

struct Popular: View {
    var item: Meal
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 6) {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                ArticleImage(imageLoader: ImageLoaderCache.shared.loaderFor(article: item))
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(8)
                
                Image("povarenok")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 15, height: 15, alignment: .center)
                    .cornerRadius(4, corners: [.bottomRight, .topLeft])
            })
            
            Text(item.name)
                .font(.system(size: 14))
                .foregroundColor(Color(UIColor.black))
                .frame(height: 35)
                .lineLimit(2)
            
            Text(String(item.stringTime ?? ""))
                .foregroundColor(Color.gray)
                .font(.system(size: 12))
                .fontWeight(.semibold)
            
            Star(star: item.star)
        }.padding(.top, 3).padding(.leading, 3).padding(.trailing, 3).padding(.bottom, 3)
            .frame(width: 148, height: 186, alignment: .center)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
    }
}

struct Popular_Previews: PreviewProvider {
    static var previews: some View {
        Popular(item: ContentViewModel().allItems[0])
    }
}
