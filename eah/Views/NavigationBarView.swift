//
//  NavigationBarView.swift
//  eah
//
//  Created by Danil Ilichev on 27.04.2021.
//

import SwiftUI

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        NavigationView {
            Text("SwiftUI tutorials")
                .navigationBarTitle("Master view")
                .navigationBarTitleDisplayMode(.inline
                )
            .navigationBarItems(leading:
                    Button(action: {
                        print("SF Symbol button pressed...")
                    }) {
                        Image(systemName: "calendar.circle").imageScale(.large)
                    },
                trailing:
                    Button(action: {
                        print("Edit button pressed...")
                    }) {
                        Text("Edit")
                    }
            ).background(Color(.gray))
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
