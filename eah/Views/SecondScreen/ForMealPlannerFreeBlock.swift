import SwiftUI

struct ForMealPlannerFreeBlock: View {
    var color: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(color)
            VStack(alignment: .leading, spacing: 5) {
                Image("rectangle3")
                Image("rectangle2")
                Image("rectangle1")
            }
            Spacer()
        }
    }
}

struct ForMealPlannerFreeBlock_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen()
    }
}
