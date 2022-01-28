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
        }
    }
}

struct IngridientView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
