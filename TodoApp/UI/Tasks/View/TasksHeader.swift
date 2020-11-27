//
//  TasksHeader.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/16.
//

import SwiftUI

struct TasksHeader: View {
    let filter: TasksFilter
    let sorting: TasksSorting

    @State private var presentsFilterActionSheet = false

    @State private var presentsSotingActionSheet = false

    // TODO: review text colors.
    var body: some View {
        HStack {
            Button(action: {
                presentsFilterActionSheet.toggle()
            }, label: {
                Image(systemName: "chevron.down")
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .font(Font.subheadline)
                Text(filter.label)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }).actionSheet(isPresented: $presentsFilterActionSheet) {
                ActionSheet(title: Text(L10n.Tasks.Filter.label), buttons: filterActionButtons())
            }
            Spacer()
            Button(action: {
                presentsSotingActionSheet.toggle()
            }, label: {
                Label(sorting.label, systemImage: "line.horizontal.3.decrease.circle.fill")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }).actionSheet(isPresented: $presentsSotingActionSheet) {
                ActionSheet(title: Text(L10n.Tasks.SortBy.label), buttons: sortingActionButtons())
            }
            Button(action: {}, label: {
                sorting.order.icon
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .font(Font.subheadline.weight(.semibold))
                    .padding(.all, 4)
            })
        }.padding([.vertical], 12)
    }

    private func filterActionButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = TasksFilter.allCases.map { filter in
            .default(Text(filter.label)) {
                // TODO: callback
            }
        }
        buttons.append(.cancel())
        return buttons
    }

    private func sortingActionButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = TasksSorting.allCases(sorting.order).map { sorting in
            .default(Text(sorting.label)) {
                // TODO: callback
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
                filter: .all,
                sorting: .title(order: .asc)
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)

            TasksHeader(
                filter: .active,
                sorting: .createdDate(order: .desc)
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
        }
    }
}
