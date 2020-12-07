//
//  Checkmark.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/05.
//

import SwiftUI

struct Checkmark: View {
    let checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square" : "square")
            .font(Font.headline.bold())
    }
}

struct Checkmark_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Checkmark(checked: true)
            Checkmark(checked: false)
        }.previewLayout(.sizeThatFits)
    }
}
