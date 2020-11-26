//
//  StatisticsView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        NavigationView {
            Text(L10n.Statistics.title)
                .navigationBarTitle(Text(L10n.Statistics.title), displayMode: .inline)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
