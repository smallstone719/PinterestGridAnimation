//
//  HomeView.swift
//  PinterestGridAnimation
//
//  Created by Thach Nguyen Trong on 5/7/24.
//

import SwiftUI

struct HomeView: View {
    @State private var posts: [Item] = sampleItems
    var coordinator: UICoordinator = .init()
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 15) {
                Text("Welcome Back !")
                    .font(.largeTitle.bold())
                    .padding(.vertical, 10)
                
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), spacing: 10) {
                    ForEach(posts) { post in
                        PostCardView(post)
                    }
                }
            }
            .padding(15)
            .background(ScrollViewExtractor {
                coordinator.scrollView = $0
            })
        }
        .opacity(coordinator.hideRootView ? 0 : 1)
        .scrollDisabled(coordinator.hideRootView)
        .allowsTightening(!coordinator.hideRootView)
        .overlay {
            DetailView()
                .environment(coordinator)
                .allowsTightening(!coordinator.hideLayer)
//            if let animationLayer = coordinator.animationLayer {
//                Image(uiImage: animationLayer)
//                    .ignoresSafeArea()
//                    .opacity(0.5)
//            }
        }
    }
    
    @ViewBuilder
    func PostCardView(_ post: Item) -> some View {
        GeometryReader {
            let frame = $0.frame(in: .global)
            
            ImageView(post: post)
                .clipShape(.rect(cornerRadius: 10))
                .contentShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    coordinator.toogleView(show: true, frame: frame, post: post)

                }
        }
        .frame(height: 220)
    }
}

#Preview {
    ContentView()
}
