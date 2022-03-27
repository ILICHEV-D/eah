//
//  FourthScreen.swift
//  eah
//
//  Created by Danil Ilichev on 27.04.2021.
//

import SwiftUI

struct FourthScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State private var show_modal: Bool = false
    
    @State private var showingOptions = false
    
    @State var showDeletePicker: Bool = false
    
    var body: some View {
        NavigationView {
            
            VStack{
                if viewModel.shoppingList.count == 0 {
                    HStack {
                        Spacer()
                        Text("Список покупок").fontWeight(.semibold)
                        Spacer()
                    }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                    Spacer()
                    VStack(spacing: 20.0) {
                        Image("basket").resizable().frame(width: 230, height: 230, alignment: .center)
                        Text("Ваш список покупок будет здесь")
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    }.padding(.horizontal).padding(.vertical)
                    Spacer()
                }
                
                else {
                    ZStack{
                        Spacer()
                        Text("Список покупок").fontWeight(.semibold)
                        Spacer()
                    }.ignoresSafeArea().padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                    
                    ScrollView(showsIndicators: false, content: {
                        ForEach(viewModel.shoppingList.sorted(by: { $0.key.name > $1.key.name }), id: \.key){ //!!!
                            key, value in
                            HStack{
                                Text(key.name)
                                    .foregroundColor(.gray)
                                Spacer()
                                
                                HStack{
                                    
                                    Button(action: {
                                        if viewModel.shoppingList[key]! != 0 {
                                            viewModel.shoppingList[key]! -= 1
                                        }
                                        if viewModel.shoppingList[key]! == 0 {
                                            viewModel.shoppingList[key] = nil
                                            if let index = viewModel.selectedForBuyIngredients.firstIndex(of: key) {
                                                viewModel.selectedForBuyIngredients.remove(at: index)
                                                viewModel.suggestedForBuyIngredients.append(key)
                                            }}
                                        
                                    }, label: {
                                        Image(systemName: "minus")
                                            .font(.system(size: 14, weight: .medium))
                                            .frame(width: 28, height: 28, alignment: .center).cornerRadius(9.5)
                                            .background(Color(UIColor.systemGray).opacity(0.12))
                                            .foregroundColor(Color(UIColor.systemGray))
                                    }).cornerRadius(4)
                                }
                                
                                Text("\(value)").padding(.all, 5)
                                
                                
                                Button(action: {
                                    viewModel.shoppingList[key]! += 1
                                }, label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 14, weight: .medium))
                                        .frame(width: 28, height: 28, alignment: .center).cornerRadius(9.5)
                                        .background(Color(UIColor.systemGray).opacity(0.12))
                                        .foregroundColor(Color(UIColor.systemGray))
                                }).cornerRadius(4)
                                
                                Button(action: {
                                    viewModel.shoppingList[key] = nil
                                    if let index = viewModel.selectedForBuyIngredients.firstIndex(of: key) {
                                        viewModel.selectedForBuyIngredients.remove(at: index)
                                        viewModel.suggestedForBuyIngredients.append(key)
                                    }
                                }, label: {
                                    Image("trashAddIngridients")
                                }).padding(.leading, 15)
                            }.padding(.bottom)
                        }
                        
                        Button(action: {
                            showingOptions = true
                        }) {
                            Text("Удалить все")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(UIColor.systemGray))
                                .padding()
                                .frame(width: 130, height: 30, alignment: .center)
                                .background(Color(UIColor.systemGray).opacity(0.12))
                                .cornerRadius(16)
                                .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                .cornerRadius(4)
                        }
                        .alert(isPresented: $showingOptions) {
                            Alert(title: Text("Вы уверены, что хотите удалить все продукты?"),
                                  primaryButton: .destructive(Text("Удалить")) {
                                for i in viewModel.shoppingList {
                                    if let index = viewModel.selectedForBuyIngredients.firstIndex(of: i.key) {
                                        viewModel.selectedForBuyIngredients.remove(at: index)
                                        viewModel.suggestedForBuyIngredients.append(i.key)
                                    }
                                }
                                viewModel.shoppingList = [:]
                            },
                                  secondaryButton: .cancel()
                            )
                        }
                    }).padding()
                }
                
                
                Button(action: {
                    self.show_modal = true
                }) {
                    HStack {
                        Text("Добавить ингредиенты")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                        Image("plus")
                            .padding()
                    }
                    .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                    .background(Color("mainColor"))
                    .cornerRadius(16)
                    .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                }.padding().sheet(isPresented: self.$show_modal) {
                    ThirdScreen(forAddIngridient: true)
                }
            }.navigationBarHidden(true)
            
        }.navigationBarHidden(true)
    }
    
    func getColor() -> String {
        if viewModel.selectedForBuyIngredients.count != 0 {
            return  "mainColor"}
        else {
            return "arrowGrayColor"
        }}
    
}

struct FourthScreen_Previews: PreviewProvider {
    static var previews: some View {
        FourthScreen()
    }
}
