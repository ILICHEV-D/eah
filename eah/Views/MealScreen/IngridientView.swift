//
//  IngridientView.swift
//  eat_at_hand
//
//  Created by Danil Ilichev on 22.04.2021.
//

import SwiftUI

struct IngridientView: View {
    
    var item: Ingridient
    
    var body: some View {
        HStack (spacing: 30){
            Text(item.imageSmile)
                .font(.system(size: 26))
                .frame(width: 65, height: 65, alignment: .center)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(16)
            Text(item.name).font(.system(size: 16))
            Spacer()
        }
    }
}

struct IngridientView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
