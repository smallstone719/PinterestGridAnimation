//
//  DetailView.swift
//  PinterestGridAnimation
//
//  Created by Thach Nguyen Trong on 5/7/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(UICoordinator.self) private var coordinator
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let animateView = coordinator.animateView
            let hideLayer = coordinator.hideLayer
            let rect = coordinator.rect
            
            let anchorX = (coordinator.rect.minX / size.width) > 0.5  ? 1.0 : 0.0
            let scale = size.width / coordinator.rect.width
            
            /// 15 = Horizontal padding
            let offsetX = animateView ? (anchorX > 0.5 ? 15 : -15) * scale : 0
            let offsetY = animateView ? -coordinator.rect.minY * scale : 0
            /**
             Optional:
             If you want a three-column grid display, simply change these two in the Detail View,
             1. let anchorX = (coordinator.rect.minX / size.width) > 0.5 ? 1.0 : ((coordinator.rect.minX / size.width) > 0.25 ? 0.5 : 0.0)
             2. let offsetX = animateView && anchorX != 0.5 ? (anchorX > 0.5 ? 15 : -15) * scale : 0
             Have a great day Folks!
             */
            
            let detailHeight: CGFloat = rect.height * scale
            let scrollContentHeight: CGFloat = size.height - detailHeight
            
            if let uiImage = coordinator.animationLayer, let post = coordinator.selectedItem {
                if !hideLayer {
                    Image(uiImage: uiImage)
                        .scaleEffect(animateView ? scale : 1, anchor: .init(x: anchorX, y: 0))
                        .offset(x: offsetX, y: offsetY)
                        .offset(y: animateView ? -coordinator.headerOffset : 0)
                        .opacity(animateView ? 0 : 1)
                        .transition(.identity)
                }
                
                   
                
                ScrollView(.vertical) {
                    ScrollContent()
                        .safeAreaInset(edge: .top, spacing: 0) {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: detailHeight)
                                .offsetY { offset in
                                    coordinator.headerOffset = max(min(-offset, detailHeight), 0)
                                }
                        }
                }
                .scrollDisabled(!hideLayer)
                .contentMargins(.top, detailHeight, for: .scrollIndicators)
                .background {
                    Rectangle()
                        .fill(.background)
                        .padding(.top, detailHeight)
                }
                .animation(.easeIn(duration: 0.3).speed(1.5)) {
                    $0.offset(y: animateView ? 0 : scrollContentHeight)
                        .opacity(animateView ? 1 : 0)
                }
                
                ImageView(post: post)
                    .allowsHitTesting(false)
                    .frame(
                        width: animateView ? size.width : rect.width,
                        height: animateView ? rect.height * scale : rect.height
                    )
                    .clipShape(.rect(cornerRadius:  animateView ? 0 : 10))
                    .overlay(alignment: .top) {
                        HeaderActions(post)
                            .offset(y: coordinator.headerOffset)
                            .padding(.top, safeAreaInsets.top)
                    }
                    .offset(x: animateView ? 0 : rect.minX, y: animateView ? 0 : rect.minY)
                    .offset(y: animateView ? -coordinator.headerOffset : 0)
            }
        }
        .ignoresSafeArea()
    }
    @ViewBuilder
    func ScrollContent() -> some View {
        DummyView()
    }
    
    @ViewBuilder
    func HeaderActions(_ post: Item) -> some View {
        HStack {
            Spacer(minLength: 0)
            
            Button(action: {
                coordinator.toogleView(show: false, frame: .zero, post: post)
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.large)
                    .font(.title)
                    .foregroundStyle(Color.primary, .bar)
                    .padding(.trailing)
                    .contentShape(.rect)
            })
            .animation(.easeInOut(duration: 0.3)) {
                $0.opacity(coordinator.hideLayer ? 1 : 0)
            }
        }
    }
}

#Preview {
    ContentView()
}


