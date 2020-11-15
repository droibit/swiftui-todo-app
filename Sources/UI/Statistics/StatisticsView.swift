//
//  StatisticsView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        Text(L10n.Statistics.title)
            .tabItem {
                Image(systemName: "ellipsis.circle")
                Text(L10n.Statistics.title)
            }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
