//
//  FourthScreen.swift
//  eah
//
//  Created by Danil Ilichev on 27.04.2021.
//

import SwiftUI

struct FourthScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel

    @State var modalIsPresented = false

//
    @State private var show_modal: Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
        //    viewModel.selectedIngredients.reduce(into: [String: Int]()) { $0[$1] = 0 }
    
//    @State var items: [String]
    
//    @State var items: [String: Int] = [:]
    
    


    
    var body: some View {
        NavigationView {
            
            //    ScrollView {
            
            VStack{
            
            if viewModel.shoppingList.count == 0 {
            

                
                HStack {
                    Spacer()
                    Text("Shopping list").fontWeight(.semibold)
                    Spacer()
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                ScrollView{
                
                Spacer()
                VStack(spacing: 20.0) {
                    Image("basket")
                    
                    Text("Your shopping - list will be here")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }.padding()
                Spacer()
                }
                

            }

                else {
                        ZStack{
                            Spacer()
                            Text("Shopping list").fontWeight(.semibold)
                            Spacer()
                        }.ignoresSafeArea().padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)

                        ScrollView(showsIndicators: false, content: {
                            ForEach(viewModel.shoppingList.sorted(by: >), id: \.key){
                                key, value in
                                HStack{
                                    Text(key)
                                        .foregroundColor(.gray)

                                    Spacer()

                                    HStack{
                                        Button(action: {
                                            viewModel.shoppingList[key]! += 1
                                        }, label: {
                                            Image(systemName: "plus")
                                                .font(.system(size: 14, weight: .medium))
                                                .frame(width: 28, height: 28, alignment: .center).cornerRadius(9.5)
                                                .background(Color(UIColor.systemGray).opacity(0.12))
                                                .foregroundColor(Color(UIColor.systemGray))
                                        }).cornerRadius(4)

                                        Text("\(value)").padding(.all, 5)

                                        Button(action: {
                                            if viewModel.shoppingList[key]! != 0 {
                                                viewModel.shoppingList[key]! -= 1
                                            }
                                        }, label: {
                                            Image(systemName: "minus")
                                                .font(.system(size: 14, weight: .medium))
                                                .frame(width: 28, height: 28, alignment: .center).cornerRadius(9.5)
                                                .background(Color(UIColor.systemGray).opacity(0.12))
                                                .foregroundColor(Color(UIColor.systemGray))
                                        }).cornerRadius(4)

                                    }

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


                        }).padding()
                }
            
                
            Button(action: {
                self.show_modal = true
            }) {
                HStack {
                    Text("Add ingridients")
                        .font(.system(size: 16))
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
        if viewModel.selectedIngredients.count != 0 {
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
