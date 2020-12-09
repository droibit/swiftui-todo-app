//
//  StatisticsUiStateView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/09.
//

import SwiftUI

struct StatisticsUiStateView: View {
    let uiState: StatisticsUiState

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text(L10n.Statistics.activeTasks)
                    .font(.title3)
                    .bold()
                Text("\(uiState.activeTaskCount)")
                    .font(.title3)
            }

            VStack(spacing: 8) {
                Text(L10n.Statistics.completedTasks)
                    .font(.title3)
                    .bold()
                Text("\(uiState.completedTaskCount)")
                    .font(.title3)
            }
        }
    }
}

// MARK: - Previews

struct StatisticsUiStateView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsUiStateView(
            uiState: .init(
                activeTaskCount: 0,
                completedTaskCount: 1
            )
        )
    }
}
