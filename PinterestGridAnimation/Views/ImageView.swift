//
//  ImageView.swift
//  PinterestGridAnimation
//
//  Created by Thach Nguyen Trong on 5/7/24.
//

import SwiftUI

struct ImageView: View {
    var post: Item
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            if let uiImage = post.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
            }
        }
    }
}
