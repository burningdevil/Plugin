//
//  IconImage.swift
//  Selected
//
//  Created by sake on 2024/3/18.
//

import Foundation
import SwiftUI

struct Icon: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body : some View {
        
        if text.starts(with: "file://") {
            // load from a file
            
            let im: NSImage =
            {
                
                        $0.size.height = 10
                        $0.size.width = 10
                
                return $0
            }(
                NSImage(contentsOfFile: text.trimPrefix("file://"))!
            )
           return
                AnyView(Image(nsImage: im).resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20).frame(width: 30, height: 30))
        } else if text.starts(with: "symbol:") {
            return
                AnyView(Image(systemName: text.trimPrefix("symbol:")).resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20).frame(width: 30, height: 30)
                )
        }
        
        let t = text.split(separator: " ")
        guard t.count == 2 else {
            return AnyView(Image(systemName: "bitcoinsign"))
        }
        
        let shape = String(t[0])
        let characters = String(t[1])
        guard characters.count <= 3 else {
            return AnyView(Image(systemName: shape))
        }
        
        var size = 14
        if characters.count == 2{
            size = 8
        } else if characters.count == 3 {
            size = 5
        }
        
        return AnyView(Image(systemName: shape).resizable().frame(width: 20, height: 20)
            .overlay {
                Text(characters).font(.system(size: CGFloat(size)))
            }.frame(width: 30, height: 30))
    }
}
