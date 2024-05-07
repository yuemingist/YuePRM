//
//  ActivityEntry.swift
//  Personal Relationship Management
//
//  Created by Taylor Geisse on 3/20/23.
//

import SwiftUI

struct ActivityEntry: View {
    @State private var addingActivity = false
    
    var body: some View {
        RealmListSplitView(singularTitle: "Activity".localized,
                           pluralTitle: "Activities".localized,
                           listRowView: listItemView,
                           detailView: detailView,
                           addForm: addEntry)
    }
    
    private func listItemView(_ activity: Activity) -> some View {
        ActivityListItem(activity: activity)
    }
    
    private func detailView(_ activity: Activity) -> some View {
        ActivityView(activity: activity)
    }
    
    private func addEntry() -> AnyView {
        AnyView(ActivityForm(activity: Activity(), formMode: .adding))
    }
}

#if DEBUG
struct ActivityEntry_Previews: PreviewProvider {
    static var previews: some View {
        ActivityEntry()
    }
}
#endif
