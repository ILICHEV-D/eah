//
//  IngredientSmallViews.swift
//  eah
//
//  Created by Danil Ilichev on 28.01.2022.
//

import Foundation
import SwiftUI

struct IngredientSmallView: View {
    var item: Ingredient
    
    var body: some View {
        VStack(spacing: 5){
            Text(item.imageSmile)
                .font(.system(size: 26))
                .frame(width: 68, height: 68, alignment: .center)
                .background(item.color)
                .cornerRadius(16)
                .multilineTextAlignment(.center)
            
            Text(item.name).font(.system(size: 12))
                .fontWeight(.medium)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
}

struct IngredientSmallViewWithClose: View {
    var item: Ingredient
    
    var body: some View {
        VStack(spacing: 5){
            Image("close").padding(.trailing, 85).padding(.top, -15)
            
            Text(item.imageSmile)
                .font(.system(size: 26))
                .frame(width: 68, height: 68, alignment: .center)
                .background(item.color)
                .cornerRadius(16)
                .padding(.top, -3)
            
            Text(item.name).font(.system(size: 12))
                .fontWeight(.medium).padding(.top, 6)
                .foregroundColor(.black)
        }
        .frame(width: 100, height: 115, alignment: .center)
        .background(
            Color.white
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 3, y: 3)
        )
    }
}
