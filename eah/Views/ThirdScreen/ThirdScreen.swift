//
//  ThirdScreen.swift
//  eah
//
//  Created by Danil Ilichev on 24.04.2021.
//

import SwiftUI

struct ThirdScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    @State var searchQuery = ""
    var forAddIngridient: Bool?
    @Environment(\.presentationMode) private var presentationMode
    
    //    @Binding var itemsOfFourhScreen: [String: Int]?
    
    
    //    init(searchTxt: Binding<String?>?) {
    //        self._searchTxt = searchTxt ?? Binding.constant(nil)
    //    }
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                HStack {
                    Spacer()
                    Text("Выбрать ингредиенты").fontWeight(.semibold)
                    Spacer()
                    
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                HStack {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.gray)
                        
                        TextField("Поиск", text: $searchQuery, onCommit:  {
                            UIApplication.shared.endEditing()
                        })
                        
                        Button(action: {
                            searchQuery = ""
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
                
                ZStack(alignment: .bottom, content: {
                
                if forAddIngridient == nil { //!!!

                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    if viewModel.selectedIngredients.count != 0 {
                        HStack {
                            Text("Выбранные ингредиенты").font(.system(size: 18))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.trailing).padding(.top).padding(.leading)
                    }
                    
                    LazyVGrid(columns: columns, content: {
                        
                        ForEach(viewModel.selectedIngredients.sorted {$0 < $1} , id:\.self){
                            ingr in
                            let item = convertIngridient(item: helpEnumIngredients.init(rawValue: ingr)!)
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    viewModel.suggestedIngredients.append(ingr)
                                }
                                if let index = viewModel.selectedIngredients.firstIndex(of: ingr) {
                                    viewModel.selectedIngredients.remove(at: index)
                                }
                                //              }
                                
                            }, label: {
                                
                                
                                VStack(spacing: 5){
                                    Image("close").padding(.trailing, 85).padding(.top, -15)
                                    
                                    Text(item.imageSmile)
                                        .font(.system(size: 26))
                                        .frame(width: 68, height: 68, alignment: .center)
                                        .background(item.color)
                                        .cornerRadius(16)
                                        .padding(.top, -3)
                                    
                                    Text(item.name).font(.system(size: 12))
                                        .fontWeight(.semibold).padding(.top, 6)
                                        .foregroundColor(.black)
                                }
                                .frame(width: 100, height: 115, alignment: .center)
                                .background(
                                    Color.white
                                        .cornerRadius(16)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
                                )
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
                                    viewModel.suggestedIngredients.filter{$0.lowercased().contains(searchQuery.lowercased())} , id:\.self){
                            ingr in
                            let item = convertIngridient(item: helpEnumIngredients.init(rawValue: ingr)!)
                            Button(action: {
                                withAnimation(.spring()){
                                    viewModel.selectedIngredients.append(ingr)
                                }
                                if let index = viewModel.suggestedIngredients.firstIndex(of: ingr) {
                                    viewModel.suggestedIngredients.remove(at: index)
                                }
                                
//                                if forAddIngridient == true {
//                                    viewModel.shoppingList = viewModel.selectedIngredients.reduce(into: [String: Int]()) { $0[$1] = 0 }
//                                }
                                
                            }, label: {
                                VStack(spacing: 5){
                                    Text(item.imageSmile)
                                        .font(.system(size: 26))
                                        .frame(width: 68, height: 68, alignment: .center)
                                        .background(item.color)
                                        .cornerRadius(16)
                                    
                                    Text(item.name).font(.system(size: 12))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                }
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
                    
                }
                
                else {
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        if viewModel.selectedForBuyIngredients.count != 0 {
                            HStack {
                                Text("Выбранные ингредиенты").font(.system(size: 18))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding(.trailing).padding(.top).padding(.leading)
                        }
                        
                        LazyVGrid(columns: columns, content: {
                            
                            ForEach(viewModel.selectedForBuyIngredients.sorted {$0 < $1} , id:\.self){
                                ingr in
                                let item = convertIngridient(item: helpEnumIngredients.init(rawValue: ingr)!)
                                
                                Button(action: {
                                    withAnimation(.spring()) {
                                        viewModel.suggestedForBuyIngredients.append(ingr)
                                    }
                                    if let index = viewModel.selectedForBuyIngredients.firstIndex(of: ingr) {
                                        viewModel.selectedForBuyIngredients.remove(at: index)
                                    }
                                    
                                }, label: {
                                    
                                    
                                    VStack(spacing: 5){
                                        Image("close").padding(.trailing, 85).padding(.top, -15)
                                        
                                        Text(item.imageSmile)
                                            .font(.system(size: 26))
                                            .frame(width: 68, height: 68, alignment: .center)
                                            .background(item.color)
                                            .cornerRadius(16)
                                            .padding(.top, -3)
                                        
                                        Text(item.name).font(.system(size: 12))
                                            .fontWeight(.semibold).padding(.top, 6)
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 100, height: 115, alignment: .center)
                                    .background(
                                        Color.white
                                            .cornerRadius(16)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
                                    )
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
                                        viewModel.suggestedForBuyIngredients.filter{$0.lowercased().contains(searchQuery.lowercased())} , id:\.self){
                                ingr in
                                let item = convertIngridient(item: helpEnumIngredients.init(rawValue: ingr)!)
                                Button(action: {
                                    withAnimation(.spring()){
                                        viewModel.selectedForBuyIngredients.append(ingr)
                                    }
                                    if let index = viewModel.suggestedForBuyIngredients.firstIndex(of: ingr) {
                                        viewModel.suggestedForBuyIngredients.remove(at: index)
                                    }
                                    
    //                                if forAddIngridient == true {
    //                                    viewModel.shoppingList = viewModel.selectedIngredients.reduce(into: [String: Int]()) { $0[$1] = 0 }
    //                                }
                                    
                                }, label: {
                                    VStack(spacing: 5){
                                        Text(item.imageSmile)
                                            .font(.system(size: 26))
                                            .frame(width: 68, height: 68, alignment: .center)
                                            .background(item.color)
                                            .cornerRadius(16)
                                        
                                        Text(item.name).font(.system(size: 12))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                    }
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
                    
                }
                
                if forAddIngridient == nil {
                    
                    NavigationLink(destination: ListOfMeals(items: viewModel.allItems.filter {
                                                                if let ingr = $0.ingridients {
                                                                    return Set(viewModel.selectedIngredients).isSubset(of: Set(ingr))
                                                                }
                                                                return false}
                                                            
                    )){
                        HStack {
                            Text("Искать с \(viewModel.selectedIngredients.count) ингредиентами")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                            Image("arrow")
                        }.padding()
                        .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                        .background(Color(getColor()))
                        .cornerRadius(16)
                        .shadow(color: Color(getColor()).opacity(0.2), radius: 5, x: 3, y: 3)
                    }.padding()
                }
                
                else {
                    
                    Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                 //           viewModel.shoppingList = viewModel.selectedIngredients.reduce(into: [String: Int]()) { $0[$1] = 0 }

              //          print("111111")
                    }, label: {
                        HStack {
                            Text("Добавить \(viewModel.selectedForBuyIngredients.count) ингредиентов")
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
                        viewModel.shoppingList = viewModel.selectedForBuyIngredients.reduce(into: [String: Int]()) { $0[$1] = 1 }

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
