//
//  ActivityListItem.swift
//  Personal Relationship Management
//
//  Created by Taylor Geisse on 3/21/23.
//

import SwiftUI
import RealmSwift

struct ActivityListItem: View {
    @ObservedRealmObject var activity: Activity
    
    var body: some View {
        DetailViewActivityEventView(title: activity.title,
                                    date: activity.date,
                                    note: activity.notes,
                                    type: activity.type.rawValue)
    }
}

#if DEBUG
struct ActivityListItem_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListItem(activity: Activity.activity1)
    }
}
#endif
