//
//  UICoordinator.swift
//  PinterestGridAnimation
//
//  Created by Thach Nguyen Trong on 5/7/24.
//

import SwiftUI
import Observation

@Observable
class UICoordinator {
    /// Shared view properties between Home and Detail View
    var scrollView: UIScrollView = .init(frame: .zero)
    var rect: CGRect = .zero
    var selectedItem: Item? 
    /// Animation Layer Properties
    var animationLayer: UIImage?
    var animateView: Bool = false
    var hideLayer: Bool = false
    /// Root View Properties
    var hideRootView: Bool =  false
    
    /// Detail View Properties
    var headerOffset: CGFloat = .zero
    
    /// This will capture a screenshot of the scrollview's visible region,
    /// not complete scroll content.
    func createVisibleAreaSnapshot() {
        let renderer = UIGraphicsImageRenderer(size: scrollView.bounds.size)
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: -scrollView.contentOffset.x, y: -scrollView.contentOffset.y)
            scrollView.layer.render(in: ctx.cgContext)
        }
        
        animationLayer = image
    }
    
    func toogleView(show: Bool, frame: CGRect, post: Item) {
        if show {
          selectedItem = post
            /// Storing view's Rect
            rect = frame
            /// Generating ScrollView's visible area snapshot
            createVisibleAreaSnapshot()
            hideRootView = true
            
            /// Animating View
            withAnimation(.easeInOut(duration: 0.3), completionCriteria: .removed) {
                animateView = true
            } completion: {
                self.hideLayer = true
            }
        } else {
           hideLayer = false
            withAnimation(.easeInOut(duration: 0.3), completionCriteria: .removed) {
                animateView = false
            } completion: {
                DispatchQueue.main.async {
                    self.resetAnimationProperties()
                }
            }

        }
    }
    
    private func resetAnimationProperties() {
        headerOffset = 0
        hideRootView = false
        selectedItem = nil
        animationLayer = nil
    }
}

/// This will extract the UIKit ScrollView from the SwiftUI ScrollView
struct ScrollViewExtractor: UIViewRepresentable {
    var result: (UIScrollView) -> ()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            if let scrollView = view.superview?.superview?.superview as? UIScrollView {
                result(scrollView)
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
