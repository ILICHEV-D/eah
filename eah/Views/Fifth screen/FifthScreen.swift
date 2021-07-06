//
//  FifthScreen.swift
//  eah
//
//  Created by Danil Ilichev on 27.04.2021.
//



import SwiftUI

struct FifthScreen: View {
    
    
    @EnvironmentObject var viewModel: ContentViewModel
    @State private var selectorIndex = 1
    @State private var numbers = ["Favorites", "Recipe", "Support"]
    
    var body: some View {
        NavigationView{
            VStack{
            
            HStack {
                Spacer()
                Text("Аккаунт").fontWeight(.semibold)
                Spacer()
            }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
            
            ScrollView{
                VStack(spacing: 10) {
                Image(systemName: "person.fill")
                    .frame(width: 72, height: 72, alignment: .center)
                    .background(Color(.systemGray5))
                    .cornerRadius(36)
                    .padding(.bottom, 10)
                Text("Юлия Гаврилова")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Text("Дизайнер")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.top, -6)
                
                Picker("Numbers", selection: $selectorIndex) {
                                ForEach(0 ..< numbers.count) { index in
                                    Text(self.numbers[index]).tag(index)
                                }
                            }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 19).padding(.top, 25)
                          
                            // 3.
                if selectorIndex == 0 {
                    VStack {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 16){
                            ForEach(viewModel.favoriteMeals){
                                item in

                                NavigationLink(
                                    destination: MealView(item: item, fromMealPlanner: false),
                                    label: {
                                        MealPlanner(item: item)
                                    }
                                )
                            }
                        }.padding()
                    })
//
//                                                                    NavigationLink(
//                                                                        destination: ListOfMeals(),
//                                                                        label: {
                        NavigationLink(destination: ListOfMeals(items: viewModel.allItems)){
                                                    HStack {
                                                        Text("Больше рецептов")
                                                            .font(.system(size: 16))
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(.white)
                                                        Spacer()
                                                        Image("arrow")
                                                    }.padding()
                                                    .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                                    .background(Color("mainColor"))
                                                    .cornerRadius(16)
                                                    .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                        }
                                                          //              })
                    }
                                                
                }
                else if selectorIndex == 1 {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 16){
                            
                            Image("frameAddRecipe")
                                .resizable()
                                .frame(width: 220, height: 300, alignment: .center)

                            
                            ForEach(viewModel.mealPlanner){
                                item in

                                NavigationLink(
                                    destination: MealView(item: item, fromMealPlanner: false),
                                    label: {
                                        MealPlanner(item: item)
                                    }
                                )
                            }
                        }.padding()
                    })
                }
                else  if selectorIndex == 2 {
                    VStack{
                        Image("supportHeadphones")
                        Text("Как мы можем вам помочь?")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }.padding(.top, 50)
                }

                }

            }.navigationBarHidden(true)
//            .navigationBarTitle("Popular")
//            .navigationBarTitleDisplayMode(.inline)
            
            
                

        }.navigationViewStyle(StackNavigationViewStyle())
        }

    }
}

struct FifthScreen_Previews: PreviewProvider {
    static var previews: some View {
        FifthScreen().environmentObject(ContentViewModel())
    }
}
