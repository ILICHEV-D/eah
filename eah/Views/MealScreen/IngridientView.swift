//
//  IngridientView.swift
//  eat_at_hand
//
//  Created by Danil Ilichev on 22.04.2021.
//

import SwiftUI

struct IngredientView: View {
    
    var item: Ingredient
    @Binding var amount: Int
    @Binding var changeImageOfCartAll: Bool
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State var changeImageOfCart : Bool = false
    
    var body: some View {
        HStack (spacing: 15){
            Text(item.imageSmile)
                .fontWeight(.medium)
                .font(.system(size: 26))
                .frame(width: 65, height: 65, alignment: .center)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(16)
            Text(item.name).font(.system(size: 16))
                .fontWeight(.medium)
            Spacer()
            
            if item.amount != nil {
                if item.amount?.truncatingRemainder(dividingBy: 1) == 0.0 {
                    Text(String(Int((item.amount ?? 0.0)) * Int(amount)) + " " + (item.unit ?? "")).font(.system(size: 16))
                        .fontWeight(.medium)
                } else {
                    Text(String((item.amount ?? 0.0) * Double(amount)) + " " + (item.unit ?? "")).font(.system(size: 16))
                        .fontWeight(.medium)
                }
            }
            
            Button(action: {
                changeImageOfCart = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        changeImageOfCart = false
                    }
                }
                
                if !viewModel.shoppingList.contains(where: { $0.key.name == item.name}) {
                    viewModel.shoppingList[item] = Int(item.amount ?? 1)
                }
            }, label: {
                if changeImageOfCartAll {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 19, height: 19, alignment: .center)
                        .foregroundColor(Color(UIColor.systemGray2))
                } else {
                    Image(systemName: changeImageOfCart == false ? "cart.fill" : "checkmark")
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 19, height: 19, alignment: .center)
                        .foregroundColor(Color(UIColor.systemGray2))
                }
            })
            
        }
    }
}

struct IngridientView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
