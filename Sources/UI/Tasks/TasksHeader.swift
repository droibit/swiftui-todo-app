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

    // TODO: review text colors.
    var body: some View {
        HStack {
            Text(filter.label)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
            Button(action: {}, label: {
                Label(sorting.label, systemImage: "line.horizontal.3.decrease.circle.fill")
                    .font(.title3)
                    .foregroundColor(.black)
            })
            Button(action: {}, label: {
                sorting.order.icon
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .font(Font.title3.weight(.semibold))
                    .padding(.all, 8)
            })
        }.padding()
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
