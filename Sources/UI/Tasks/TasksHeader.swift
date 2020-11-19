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
            Button(action: {}, label: {
                Image(systemName: "chevron.down")
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .font(Font.subheadline)
                Text(filter.label)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            })
            Spacer()
            Button(action: {}, label: {
                Label(sorting.label, systemImage: "line.horizontal.3.decrease.circle.fill")
                    .font(.subheadline)
                    .foregroundColor(.black)
            })
            Button(action: {}, label: {
                sorting.order.icon
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .font(Font.subheadline.weight(.semibold))
                    .padding(.all, 4)
            })
        }.padding([.vertical], 12)
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
