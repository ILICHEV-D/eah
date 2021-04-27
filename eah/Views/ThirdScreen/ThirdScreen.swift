//
//  ThirdScreen.swift
//  eah
//
//  Created by Danil Ilichev on 24.04.2021.
//

import SwiftUI

struct ThirdScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    
                    if viewModel.selectedIngredients.count != 0 {
                        HStack{
                            Text("Selected Ingredients").font(.system(size: 18))
                                .fontWeight(.semibold)
                            Spacer()
                        }.padding(.trailing).padding(.top).padding(.leading)
                    }
                    
                    LazyVGrid(columns: columns, content: {
                        
                        ForEach(viewModel.selectedIngredients.sorted {$0 < $1} , id:\.self){
                            ingr in
                            let item = convertIngridient(item: helpEnumIngredients.init(rawValue: ingr)!)
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    viewModel.suggestedIngredients.append(ingr)
                                    if let index = viewModel.selectedIngredients.firstIndex(of: ingr) {
                                        viewModel.selectedIngredients.remove(at: index)
                                    }
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
                        Text("Suggested for you").font(.system(size: 18))
                            .fontWeight(.semibold)
                        Spacer()
                    }.padding(.trailing).padding(.top).padding(.leading)
                    
                    LazyVGrid(columns: columns, content: {
                        
                        ForEach(viewModel.suggestedIngredients , id:\.self){
                            ingr in
                            let item = convertIngridient(item: helpEnumIngredients.init(rawValue: ingr)!)
                            
                            
                            Button(action: {
                                
                                withAnimation(.spring())
                                {
                                    viewModel.selectedIngredients.append(ingr)
                                    if let index = viewModel.suggestedIngredients.firstIndex(of: ingr) {
                                        viewModel.suggestedIngredients.remove(at: index)
                                    }
                                }
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
                    
                    NavigationLink(destination: ListOfMeals(items: viewModel.allItems.filter {
                        
                        
                        if let ingr = $0.ingridients {
                            return Set(viewModel.selectedIngredients).isSubset(of: Set(ingr))
                        }
                        return false
                    }
                    
                    
                    )){
                        
                        HStack {
                            Text("Search with \(viewModel.selectedIngredients.count) ingridients")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                            Image("arrow")
                        }.padding()
                        .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                        .background(Color(getColor()))
                        .cornerRadius(16)
                        .shadow(color: Color(getColor()).opacity(0.2), radius: 5, x: 3, y: 3)
                    }
                }.navigationBarHidden(true).padding()
            }
            
            )
        }
        
        
    }
    
    func getColor() -> String {
        if viewModel.selectedIngredients.count != 0 {
            return  "mainColor"}
        else {
            return "arrowGrayColor"
        }}
    
}

struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThirdScreen().environmentObject(ContentViewModel())
    }
}
