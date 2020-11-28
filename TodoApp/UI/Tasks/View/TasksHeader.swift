//
//  TasksHeader.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/16.
//

import SwiftUI

struct TasksHeader: View {
    @Binding var filter: TasksFilter
    @Binding var sorting: TasksSorting

    @State private var presentsFilterActionSheet = false
    @State private var presentsSotingActionSheet = false

    // TODO: review background color.
    var body: some View {
        HStack {
            Button(action: {
                presentsFilterActionSheet.toggle()
            }, label: {
                Image(systemName: "chevron.down")
                    .renderingMode(.template)
                    .foregroundColor(.primary)
                    .font(Font.subheadline)
                Text(filter.label)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }).actionSheet(isPresented: $presentsFilterActionSheet) {
                ActionSheet(title: Text(L10n.Tasks.Filter.label), buttons: filterActionButtons())
            }
            Spacer()
            Button(action: {
                presentsSotingActionSheet.toggle()
            }, label: {
                Label(sorting.label, systemImage: "line.horizontal.3.decrease.circle.fill")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }).actionSheet(isPresented: $presentsSotingActionSheet) {
                ActionSheet(title: Text(L10n.Tasks.SortBy.label), buttons: sortingActionButtons())
            }
            Button(action: {
                sorting.toggleOrder()
            }, label: {
                sorting.order.icon
                    .renderingMode(.template)
                    .foregroundColor(.primary)
                    .font(Font.subheadline.weight(.semibold))
                    .padding(.all, 4)
            })
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.gray)
    }

    private func filterActionButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = TasksFilter.allCases.map { filter in
            .default(Text(filter.label)) {
                self.filter = filter
            }
        }
        buttons.append(.cancel())
        return buttons
    }

    private func sortingActionButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = TasksSorting.allCases(sorting.order).map { sorting in
            .default(Text(sorting.label)) {
                self.sorting = sorting
            }
        }
        buttons.append(.cancel())
        return buttons
    }
}

struct TasksHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TasksHeader(
                filter: .constant(.all),
                sorting: .constant(.title(order: .asc))
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)

            TasksHeader(
                filter: .constant(.active),
                sorting: .constant(.createdDate(order: .desc))
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
        }
    }
}
