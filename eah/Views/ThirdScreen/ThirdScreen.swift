//
//  ThirdScreen.swift
//  eah
//
//  Created by Danil Ilichev on 24.04.2021.
//

import SwiftUI

struct ThirdScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var searchQuery = ""
    @State var selection: Int? = nil
    
    var forAddIngridient: Bool?
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                //MARK: - NavigationBar
                
                HStack {
                    Spacer()
                    Text("Поиск по ингредиентам").fontWeight(.medium)
                    Spacer()
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                //MARK: - SearchBar
                
                HStack {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.gray)
                        
                        TextField("Поиск", text: $searchQuery.onChange({ someText in
                            viewModel.searchIngredients = someText
                        }), onCommit:  {
                            UIApplication.shared.endEditing()
                        })
                        
                        Button(action: {
                            searchQuery = ""
                            viewModel.searchIngredients = ""
                            UIApplication.shared.endEditing()
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 23, weight: .bold))
                                .foregroundColor(.gray)
                        })
                    }
                    .frame(height: 20)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.05))
                    .cornerRadius(8)
                }
                .padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                //MARK: - MainCode
                
                ZStack(alignment: .bottom, content: {
                    
                    //MARK: - Not for AddIngredients
                    
                    if forAddIngridient == nil {
                        ScrollView(.vertical, showsIndicators: false, content: {
                            if viewModel.selectedIngredients.count != 0 {
                                HStack {
                                    Text("Поиск по ингредиентам").font(.system(size: 18))
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                .padding(.trailing).padding(.top).padding(.leading)
                            }
                            
                            LazyVGrid(columns: columns, content: {
                                ForEach(viewModel.selectedIngredients , id:\.self){
                                    ingr in
                                    let item = convertIngridient(item:  helpEnumIngredients.init(rawValue: ingr.name), ingr: ingr)
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            if !viewModel.suggestedIngredients.contains(where: { ingredients in
                                                return ingredients.name == ingr.name
                                            }) {
                                                viewModel.suggestedIngredients.append(ingr)
                                            }
                                            
                                            if let index = viewModel.selectedIngredients.firstIndex(of: ingr) {
                                                viewModel.selectedIngredients.remove(at: index)
                                            }
                                            viewModel.searchStringMealsWithIngr = viewModel.selectedIngredients.map{$0.name}.map{String($0)}.joined(separator: ",") //!!!
                                        }
                                    }, label: {
                                        IngredientSmallViewWithClose(item: item)
                                    })
                                }.padding()
                            })
                            
                            HStack{
                                Text("Предложения для вас").font(.system(size: 18))
                                    .fontWeight(.semibold)
                                Spacer()
                            }.padding(.trailing).padding(.top).padding(.leading)
                            
                            LazyVGrid(columns: columns, content: {
                                
                                ForEach(searchQuery == "" ? viewModel.suggestedIngredients :
                                            viewModel.searchIngredientsItems
                                ){
                                    ingr in
                                    let item = convertIngridient(item:  helpEnumIngredients.init(rawValue: ingr.name), ingr: ingr)
                                    Button(action: {
                                        withAnimation(.spring()){
                                            if !viewModel.selectedIngredients.contains(where: { ingredients in
                                                return ingredients.name == ingr.name
                                            }) {
                                                viewModel.selectedIngredients.append(ingr)
                                            }
                                            
                                            
                                            if let index = viewModel.suggestedIngredients.firstIndex(of: ingr) {
                                                viewModel.suggestedIngredients.remove(at: index)
                                            }
                                            if let index = viewModel.searchIngredientsItems.firstIndex(of: ingr) {
                                                viewModel.searchIngredientsItems.remove(at: index)
                                            }
                                        }
                                        viewModel.searchStringMealsWithIngr = viewModel.selectedIngredients.map{$0.name}.map{String($0)}.joined(separator: ",") //!!!
                                        viewModel.endpoint6 = Endpoint(index: 6, limit: 1)!
                                        viewModel.endpoint6 = Endpoint(index: 6, limit: 1)!
                                        
                                    }, label: {
                                        IngredientSmallView(item: item)
                                    })
                                        .frame(width: 100, height: 115, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(16)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
                                }.padding()
                            })
                            
                            Spacer().frame(height: 70)
                            
                            
                        }).padding(.leading).padding(.trailing)
                            .onAppear {UIScrollView.appearance().keyboardDismissMode = .interactive}
                        
                        NavigationLink(destination: ListOfMeals(searchStatus: true, items: viewModel.mealWithIngredients, index: 6), tag: 0, selection: $selection) {
                            Button(action: {
                                viewModel.mealWithIngredients = []
                                viewModel.mealWithIngredientsLimit += 10
                                viewModel.endpoint6 = Endpoint(index: 6, limit: viewModel.mealWithIngredientsLimit)!
                                self.selection = 0
                            }) {
                                HStack {
                                    Text("Покзать рецепты")
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }.padding()
                                    .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                    .background(Color(getColor()))
                                    .cornerRadius(16)
                                    .shadow(color: Color(getColor()).opacity(0.2), radius: 5, x: 3, y: 3)
                            }.padding()
                        }
                    }
                    
                    //MARK: - ForAddIngredients
                    
                    else {
                        
                        ScrollView(.vertical, showsIndicators: false, content: {
                            
                            if viewModel.selectedForBuyIngredients.count != 0 {
                                HStack {
                                    Text("Поиск по ингредиентам").font(.system(size: 18))
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                .padding(.trailing).padding(.top).padding(.leading)
                            }
                            
                            LazyVGrid(columns: columns, content: {
                                
                                ForEach(viewModel.selectedForBuyIngredients.sorted {$0 > $1} , id:\.self){
                                    ingr in
                                    let item = convertIngridient(item:  helpEnumIngredients.init(rawValue: ingr.name), ingr: ingr)
                                    
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            
                                            if !viewModel.suggestedForBuyIngredients.contains(where: { ingredients in
                                                return ingredients.name == ingr.name
                                            }) {
                                                viewModel.suggestedForBuyIngredients.append(ingr)
                                            }
                                        }
                                        if let index = viewModel.selectedForBuyIngredients.firstIndex(of: ingr) {
                                            viewModel.selectedForBuyIngredients.remove(at: index)
                                        }
                                    }, label: {
                                        IngredientSmallViewWithClose(item: item)
                                    })
                                }.padding()
                            })
                            
                            HStack{
                                Text("Предложения для вас").font(.system(size: 18))
                                    .fontWeight(.semibold)
                                Spacer()
                            }.padding(.trailing).padding(.top).padding(.leading)
                            
                            LazyVGrid(columns: columns, content: {
                                
                                ForEach(searchQuery == "" ? viewModel.suggestedForBuyIngredients :
                                            viewModel.searchIngredientsItems
                                ){
                                    ingr in
                                    let item = convertIngridient(item:  helpEnumIngredients.init(rawValue: ingr.name), ingr: ingr)
                                    Button(action: {
                                        withAnimation(.spring()){
                                            
                                            if !viewModel.selectedForBuyIngredients.contains(where: { ingredients in
                                                return ingredients.name == ingr.name
                                            }) {
                                                viewModel.selectedForBuyIngredients.append(ingr)
                                            }
                                            
                                            if let index = viewModel.suggestedForBuyIngredients.firstIndex(of: ingr) {
                                                viewModel.suggestedForBuyIngredients.remove(at: index)
                                            }
                                            if let index = viewModel.searchIngredientsItems.firstIndex(of: ingr) {
                                                viewModel.searchIngredientsItems.remove(at: index)
                                            }
                                        }
                                    }, label: {
                                        IngredientSmallView(item: item)
                                    })
                                        .frame(width: 100, height: 115, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(16)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
                                }.padding()
                            })
                            
                            Spacer().frame(height: 70)
                            
                        }).padding(.leading).padding(.trailing)
                            .onAppear {UIScrollView.appearance().keyboardDismissMode = .interactive}
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Text("Добавить \(viewModel.selectedForBuyIngredients.count) ингред.")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Image("plus")
                            }.padding()
                                .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                .background(Color(getColorForBuy()))
                                .cornerRadius(16)
                                .shadow(color: Color(getColorForBuy()).opacity(0.2), radius: 5, x: 3, y: 3)
                        }).padding().onDisappear {
                            for ingredient in viewModel.selectedForBuyIngredients {
                                if !viewModel.shoppingList.contains(where: { $0.key.name == ingredient.name}) {
                                    viewModel.shoppingList[ingredient] = 1
                                } else {
                                    print("non")
                                }
                            }
                            for i in viewModel.shoppingList {
                                if !viewModel.selectedForBuyIngredients.contains(where: { $0.name == i.key.name}) {
                                    viewModel.shoppingList.removeValue(forKey: i.key)
                                }
                            }
                        }
                    }
                })
            }.navigationBarHidden(true)
        }
    }
    
    func getColor() -> String {
        if viewModel.selectedIngredients.count != 0 {
            return  "mainColor"}
        else {
            return "arrowGrayColor"
        }}
    
    func getColorForBuy() -> String {
        if viewModel.selectedForBuyIngredients.count != 0 {
            return  "mainColor"}
        else {
            return "arrowGrayColor"
        }}
    
}

struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
