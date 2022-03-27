
import SwiftUI

struct MealPlanner: View {
    
    var item: Meal
    var time: String?
    
    var body: some View {
        
        ZStack(alignment: .topLeading ){
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                    
                    ArticleImage(imageLoader: ImageLoaderCache.shared.loaderFor(article: item))
                        .frame(width: 220, height: 300, alignment: .center)
                        .cornerRadius(16)
                    
                    Image("povarenok")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(8)
                        .padding(.trailing, 5).padding(.top, 5)
                })
                
                ZStack(alignment: .leading) {
                    BlurView(style: .regular).frame(width: 197, height: 55)
                    VStack (alignment: .leading, spacing: 6, content: {
                        Text(item.name)
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text(String(item.stringTime ?? ""))
                            .fontWeight(.semibold)
                            .font(.system(size: 11))
                            .foregroundColor(Color(UIColor.systemGray5))
                            .multilineTextAlignment(.center)
                        
                    }).padding()
                }
                .frame(width: 197, height: 55, alignment: .leading)
                .cornerRadius(12)
                .padding(.bottom, 23)
                .font(.system(size: 11, weight: .medium, design: .default))
                .cornerRadius(12)
            })
            
            if (time != nil) {
                Text(time!)
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(BlurView(style: .systemUltraThinMaterial).cornerRadius(7))
                    .padding(.leading, 14)
                    .padding(.top, 12)
            }
        }
    }
}

struct MealPlanner_Previews: PreviewProvider {
    static var previews: some View {
        MealPlanner(item: ContentViewModel().allItems[5], time: "Lunch")
    }
}


struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
    }
}
