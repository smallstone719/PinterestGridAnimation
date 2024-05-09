//
//  Item.swift
//  PinterestGridAnimation
//
//  Created by Thach Nguyen Trong on 5/7/24.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    private (set) var id: UUID = .init()
    var title: String
    var image: UIImage?
}

var sampleItems: [Item] = [
    .init(title:"Abril Altamirano",image: UIImage(named: "pic-1")),
    .init(title:"Gülsah Aydogan",image: UIImage (named: "pic-2" )),
    .init(title:"Melike Sayar Melikesayar",image: UIImage(named: "pic-3")),
    .init(title:"Maahid Photos",image: UIImage(named: "pic-4")),
    .init(title:"Pelageia Zelenina", image: UIImage (named: "pic-5")),
    .init(title:"Ofir Eliav",image: UIImage (named: "pic-6")),
    .init(title: "Melike Sayar Melikesayar",image: UIImage(named: "pic-7")),
    .init(title:"Melike Sayar Melikesayar",image: UIImage(named: "pic-8")),
    .init(title:"Melike Sayar Melikesayar",image: UIImage(named: "pic-9")),
    .init(title:"Erik Mclean", image: UIImage(named: "pic-10")),
    .init(title:"Fatma DELIASLAN", image: UIImage (named: "pic-11" )),
]
