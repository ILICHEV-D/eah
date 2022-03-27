
import SwiftUI

struct Star: View {
    var star: Double?
    
    var body: some View {
        
        HStack(spacing: 3){
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 12, height: 12, alignment: .center)
                .font(.system(size: 12, weight: .black, design: .default))
                .foregroundColor(Color("mainColor"))
            
            Text(String(format: "%.1f", star ?? 0))
                .foregroundColor(Color("mainColor"))
                .font(.system(size: 14))
                .fontWeight(.bold)
        }
    }
    
}

struct Star_Previews: PreviewProvider {
    static var previews: some View {
        Star(star: 4.5)
    }
}
