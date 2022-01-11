//
//  ContentView.swift
//  Shared
//
//  Created by Danil Ilichev on 03.01.2022.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ffDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(ffDocument()))
    }
}
