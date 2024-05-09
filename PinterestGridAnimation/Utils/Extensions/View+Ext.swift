//
//  View+Ext.swift
//  PinterestGridAnimation
//
//  Created by Thach Nguyen Trong on 5/8/24.
//

import SwiftUI

extension View {
    var safeAreaInsets: UIEdgeInsets {
        if let safeAreaInsets = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeAreaInsets
        }
        return .zero
    }
    
    @ViewBuilder
    func offsetY(result: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self, perform: { value in
                            result(value)
                        })
                }
            }
    }
}

/// Preference Keys
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
