//
//  DummyView.swift
//  PinterestGridAnimation
//
//  Created by Thach Nguyen Trong on 5/8/24.
//

import SwiftUI

struct DummyView: View {
    var body: some View {
        LazyVStack {
            DummySection(title: "Social Media")
            
            DummySection(title: "Sales", isLong: true)
            
            ImageView("pic-1")
            
            DummySection(title: "Business", isLong: true)
            
            DummySection(title: "Promotion", isLong: true)
            
            ImageView("pic-2")
            
            DummySection(title: "Youtube")
            DummySection(title: "Twitter (X)")
            
            DummySection(title: "Marketing Campaign", isLong: true)
            
            ImageView("pic-3")
            
            DummySection(title: "Conclusion", isLong: true)
        }
        .padding(15)
    }
    
    @ViewBuilder
    func DummySection(title: String, isLong: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title.bold())
            Text("orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. \(isLong ? "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." : "")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func ImageView(_ image: String) -> some View {
        GeometryReader {
            let size = $0.size
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: size.height)
                .clipped()
        }
        .frame(height: 400)
    }
}

#Preview {
    DummyView()
}
