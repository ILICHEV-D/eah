import SwiftUI

struct MealView: View {
    @State var item: Meal
    let fromMealPlanner: Bool
    
    @State var numberOfPages: Int = 0
    @State private var countServings = 1
    @State private var hue: CGFloat = 0
    @GestureState private var dragOffset = CGSize.zero
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var like = true
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State private var showingAlert = false
    
    @State var changeImageOfCart : Bool = false
    
    let impactLight = UIImpactFeedbackGenerator(style: .medium)
    
    
    
    var body: some View {
        
        VStack {
            
            // MARK: - NavigationBar
            
            HStack {
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                        .background(Color(UIColor.systemGray).opacity(0.12))
                        .foregroundColor(.black)
                }).cornerRadius(9.5)
                
                
                Spacer()
                Text(item.name).fontWeight(.medium)
                Spacer()
                
                // MARK: - From meal planner
                
                if fromMealPlanner == true {
                    
                    Button(action: {
                        let indexOfMeal = viewModel.mealPlannerItems.firstIndex(where: { $0.id == item.id &&
                            ($0.dayOfWeek?.date == Date().getWeekDate(week: viewModel.selectedDay.name))
                        })
                        
                        viewModel.mealPlannerItems.remove(at: indexOfMeal!)
                        viewModel.selectedDay = viewModel.selectedDay
                        self.mode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "trash")
                            .font(.title2)
                            .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                            .background(Color(UIColor.systemGray).opacity(0.12))
                            .foregroundColor(.black)
                    }).cornerRadius(9.5)
                    
                }
                
                // MARK: - From list
                
                else {
                    Button(action: {
                        let itemUID = item.uid
                        guard AuthApi.token != nil else {
                            self.showingAlert = true
                            return
                        }
                        if viewModel.favoriteMeals.contains(item){
                            AuthApi.sendUnlike(recipeUid: itemUID,  completion: { result in
                                switch result {
                                case .success(let response):
                                    if response.status == false {
                                        print(response)
                                    } else {
                                        let index = viewModel.favoriteMeals.firstIndex(where: {$0.uid == itemUID})
                                        if let indexForRemove = index {
                                            DispatchQueue.main.async {
                                                viewModel.favoriteMeals.remove(at: indexForRemove)
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            })
                        } else {
                            impactLight.impactOccurred()
                            AuthApi.sendLike(recipeUid: itemUID,  completion: { result in
                                switch result {
                                case .success(let response):
                                    if response.status == false {
                                        print(response)
                                    } else {
                                        print(response)
                                        DispatchQueue.main.async {
                                            viewModel.favoriteMeals.append(item)
                                        }
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            })
                        }
                        
                    }, label: {
                        if viewModel.favoriteMeals.contains(item){
                            Image(systemName: "suit.heart.fill")
                                .font(.title2)
                                .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                                .background(Color(UIColor.systemGray).opacity(0.12))
                                .foregroundColor(.black)
                        }
                        else {
                            Image(systemName: "suit.heart")
                                .font(.title2)
                                .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                                .background(Color(UIColor.systemGray).opacity(0.12))
                                .foregroundColor(.black)
                        }
                    }).cornerRadius(9.5)
                }
            }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center).alert(isPresented: $showingAlert) {
                Alert(title: Text("Необходимо авторизоваться"), message: Text("Авторизуйтесь для сохранения блюд"), dismissButton: .default(Text("Хорошо")))
            }
            
            
            // MARK: - MainCode
            
            ScrollView {
                VStack(){
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                        ArticleImage(imageLoader: ImageLoaderCache.shared.loaderFor(
                            article: item))
                            .frame(width: UIScreen.screenWidth - 100, height: UIScreen.screenWidth - 100, alignment: .center)
                            .cornerRadius(15)
                            .padding(.bottom, 15)
                        
                        Image("povarenok")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30, alignment: .center)
                            .cornerRadius(8, corners: [.bottomRight, .topLeft])
                        //                            .padding(.trailing, 5)
                            .padding(.bottom, 15)
                    })
                    
                    Text(item.name)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                        .multilineTextAlignment(.center)
                    
                    Text("Калории  \(Int(item.ePower?.calories ?? 0) * countServings) 🔥").font(.system(size: 12))
                        .fontWeight(.medium)
                    
                    Text(item.description ?? "")
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 15)
                    
                    HStack(spacing: 20){
                        VStack(spacing: 7){
                            Text("Белки").font(.system(size: 14)).fontWeight(.medium)
                            Text("🍗 \(Int(item.ePower?.proteins ?? 0) * countServings) г").font(.system(size: 12)).foregroundColor(.gray).fontWeight(.medium)
                        }
                        
                        ChangeDivider()
                        VStack(spacing: 7){
                            Text("Жиры").font(.system(size: 14)).fontWeight(.medium)
                            Text("🥜 \(Int(item.ePower?.fats ?? 0) * countServings) г").font(.system(size: 12)).foregroundColor(.gray).fontWeight(.medium)
                        }
                        
                        ChangeDivider()
                        VStack(spacing: 7){
                            Text("Углеводы").font(.system(size: 14)).fontWeight(.medium)
                            Text("🍞 \(Int(item.ePower?.carbonhydrates ?? 0) * countServings) г").font(.system(size: 12)).foregroundColor(.gray).fontWeight(.medium)
                        }
                    }
                    .frame(width: UIScreen.screenWidth - 60, height: 73, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Ингредиенты")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                            Text("\(item.ingredients?.count ?? 0) продуктов")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack {
                            HStack(spacing: 3) {
                                Text(String(countServings))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .font(.system(size: 15))
                                Text("порций")
                                    .foregroundColor(.white)
                                    .font(.system(size: 13))
                                    .fontWeight(.medium)
                            }
                            
                            Button(action: {
                                if countServings != 1 {
                                    for index in (0 ..< item.ingredients!.count) {
                                        item.ingredients![index].amount = item.ingredients![index].amount ?? 1 * Double(countServings)} //!!!
                                    countServings -= 1
                                }
                            }, label: {
                                Image(systemName: "minus")
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(width: 24, height: 24, alignment: .center).cornerRadius(9.5)
                                    .background(Color(UIColor.systemGray5).opacity(0.12))
                                    .foregroundColor(.white)
                            }).cornerRadius(4)
                            
                            Button(action: {
                                countServings += 1
                            }, label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(width: 24, height: 24, alignment: .center)
                                    .cornerRadius(9.5)
                                    .background(Color(UIColor.systemGray5).opacity(0.12))
                                    .foregroundColor(.white)
                            }).cornerRadius(4)
                            
                        }
                        .frame(width: 140, height: 42, alignment: .center)
                        .background(Color("mainColor"))
                        .cornerRadius(16)
                    }.padding()
                    
                    
                    VStack(spacing: 16){
                        
                        ForEach((item.ingredients ?? []), id: \.self){
                            ingr in
                            IngredientView(item: convertIngridient(item:  helpEnumIngredients.init(rawValue: ingr.name), ingr: ingr), amount: $countServings, changeImageOfCartAll: $changeImageOfCart)
                        }
                        
                        
                    }.padding(.leading).padding(.bottom).padding(.trailing)
                    
                    Button(action: {
                        for ingredient in item.ingredients ?? [] {
                            changeImageOfCart = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                changeImageOfCart = false
                            }
                            
                            if !viewModel.shoppingList.contains(where: { $0.key.name == ingredient.name}) {
                                viewModel.shoppingList[ingredient] = Int(ingredient.amount ?? 1)
                            }
                        }
                    }, label: {
                        HStack {
                            if !changeImageOfCart {
                                Text("Добавить всё в корзину")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                            } else {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 20, weight: .medium))
                                
                                Text("Добавлено")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                            }
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                        .background(Color("mainColor"))
                        .cornerRadius(16)
                        .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                    }).padding(.bottom)
                    
                    if item.cookingStages?.count != 0 {
                        HStack{
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Этапы приготовления")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                
                            }
                            Spacer()
                        }.padding(.leading).padding(.trailing)
                        
                        
                        TabView() {
                            ForEach(Array(item.cookingStages!.enumerated()), id: \.0){ index, i in
                                VStack(alignment: .leading) {
                                    HStack(spacing: 16.0){
                                        Text(String(index + 1))
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                            .font(.system(size: 18))
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .background(Color("mainColor"))
                                            .cornerRadius(16)
                                            .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                        Text("")
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }.padding(.bottom, 5)
                                    Text(i.text ?? "")
//                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.system(size: 17))
                                        .foregroundColor(.black)
                                        .padding(.bottom, 5)
                                        .background(GeometryReader { (geometryProxy : GeometryProxy) in
                                            HStack {}
                                            .onAppear {
                                                self.hue = geometryProxy.size.height
                                            }
                                        })
                                    
                                    HStack(){
                                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                                            
                                            ArticleImage(imageLoader: ImageLoaderCache.shared.loaderForStage(
                                                article: i))
                                                .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenWidth - 60, alignment: .center)
                                                .cornerRadius(15)
                                            
                                            Image("povarenok")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 30, height: 30, alignment: .center)
                                                .cornerRadius(10, corners: [.bottomRight, .topLeft])
                                        })
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                
                                
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .id(numberOfPages)
                        .frame(height: self.hue + 450)
                        .padding()
                        
                        Text("Весь контент взят с сайта \n https://www.povarenok.ru")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                
            }.navigationBarHidden(true)
                .edgesIgnoringSafeArea(.top)
                .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                    if(value.startLocation.x < 20 && value.translation.width > 100) {
                        self.mode.wrappedValue.dismiss()
                    }
                }))
            
            
            
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView(item: ContentViewModel().allItems[0], fromMealPlanner: true)
    }
}

struct ContentView: View {
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Hello World!")
                Text("Size:  (\(geo.size.width), \(geo.size.height))")
            }
        }
    }
}

struct ChangeDivider: View {
    let color: Color = Color(UIColor.systemGray6)
    let width: CGFloat = 3
    let hight: CGFloat = 18
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: hight)
            .edgesIgnoringSafeArea(.vertical)
            .cornerRadius(1)
    }
}
