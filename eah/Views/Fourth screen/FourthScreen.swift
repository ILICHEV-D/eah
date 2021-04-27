//
//  FourthScreen.swift
//  eah
//
//  Created by Danil Ilichev on 27.04.2021.
//

import SwiftUI

struct FourthScreen: View {
    var body: some View {
        NavigationView {
        //    ScrollView {
            VStack{
                Text("Shopping List")
                Spacer()
                VStack(spacing: 20.0) {
                    Image("basket")
                    
                    Text("Your shopping - list will be here")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Text("Add ingridients")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            
                        Spacer()
                        
                        Image("plus")
                        
                    }.padding()
                    .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                    .background(Color("mainColor"))
                    .cornerRadius(16)
                    .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                })


                
   //         }
            }.padding().navigationBarHidden(true)
        }
    }
}

struct FourthScreen_Previews: PreviewProvider {
    static var previews: some View {
        FourthScreen()
    }
}
