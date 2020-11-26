//
//  InProgressView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/20.
//

import SwiftUI

struct InProgressView: View {
    var body: some View {
        ProgressView(L10n.Common.loading)
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            .foregroundColor(.black)
            .font(Font.subheadline.weight(.regular))
            .padding()
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView()
    }
}
