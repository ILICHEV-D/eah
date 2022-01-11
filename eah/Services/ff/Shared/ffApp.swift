//
//  ffApp.swift
//  Shared
//
//  Created by Danil Ilichev on 03.01.2022.
//

import SwiftUI

@main
struct ffApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ffDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
