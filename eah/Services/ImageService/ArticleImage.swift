//
//  ArticleImage.swift
//  eah
//
//  Created by Danil Ilichev on 07.11.2021.
//


import SwiftUI
struct ArticleImage: View {
    @ObservedObject var imageLoader: ImageLoader
    @State private var animate = false
    var customIndicator: Bool? = false
    
    var body: some View {
        Group {
            if !imageLoader.noData {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                    if self.imageLoader.image != nil {
                        Image(uiImage: self.imageLoader.image!)
                            .resizable()
                            .scaledToFill()
                    } else {
                        if imageLoader.url != nil {
                            Rectangle()
                                .foregroundColor(Color(UIColor.systemGray6))
                                .frame(width: (UIScreen.main.bounds.width) * 0.75,
                                       height: UIScreen.main.bounds.width  * 0.6,
                                       alignment: .center)
                                .scaledToFit()
                                .overlay(
                                    ProgressView()
                                )
                        } else {
                            EmptyView()
                        }
                    }
                })
            } else {
                EmptyView()
            }
        }
    }
}

struct ArticleImage_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImage(imageLoader: ImageLoader (url: URL(string: "https://escapp.icyftl.ru/images/get?uid=35dd51c4-a222-491d-b4f3-40929f630dd6")))
    }
}
