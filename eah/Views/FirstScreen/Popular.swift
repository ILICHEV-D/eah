import SwiftUI

struct Popular: View {
    var item: Meal
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 6) {
            
            
            Image(item.image)
                
                    .resizable()
                .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(8)
            
                
                Text(item.name)
                    .font(.system(size: 14))
                    .foregroundColor(Color(UIColor.black))
                    .fontWeight(.medium)
                
            Text(item.time)
                .foregroundColor(Color.gray)
                .font(.system(size: 12, weight: .medium, design: .default))
            
                Star(star: item.star)
                
                        
        }.frame(width: 148, height: 186, alignment: .center)
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


//struct Popular: View {
//    var item: Meal
//
//    var body: some View {
//
//        HStack {
//
//
//            Image(item.image)
//
//            VStack(alignment: .leading, spacing: 5){
//
//                Text(item.name)
//                    .font(.system(size: 14))
//                    .foregroundColor(Color(UIColor.black))
//                    .fontWeight(.medium)
//
//                Star(star: item.star)
//
//                Text(item.time)
//                    .foregroundColor(Color.gray)
//                    .font(.system(size: 12, weight: .medium, design: .default))
//
//            }
//
//        }.frame(width: 150, height: 100, alignment: .center)
//        .padding(.trailing,8)
//        .background(
//            Color.white
//                .cornerRadius(16)
//                .padding(.leading,20)
//        )
//        .cornerRadius(16)
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
//    }
//
//}
