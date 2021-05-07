//
//  CustomNavigationView.swift
//  eah
//
//  Created by Danil Ilichev on 04.05.2021.
//

import SwiftUI

struct CustomNavigationView: View {
    
    @State var searchQuery = ""
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .font(.system(size: 23, weight: .bold))
                .foregroundColor(.gray)
            
            TextField("Search", text: $searchQuery)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.primary.opacity(0.05))
        .cornerRadius(8)
        .padding(.horizontal)
        
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView()
    }
}
