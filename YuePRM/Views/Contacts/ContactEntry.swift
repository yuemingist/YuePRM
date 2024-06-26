//
//  ContactEntry.swift
//  Personal Relationship Management
//
//  Created by Taylor Geisse on 3/20/23.
//

import SwiftUI
import RealmSwift

struct ContactEntry: View {
    @State private var addingContact = false
    
    var body: some View {
        RealmListSplitViewWithFavorites(singularTitle: "Contact".localized,
                                        pluralTitle: "Contacts".localized,
                                        listRowView: listItemView,
                                        detailView: detailView,
                                        addForm: addEntry)
    }
    
    private func listItemView(_ contact: Contact) -> some View {
        ContactListItem(contact: contact)
    }
    
    private func detailView(_ contact: Contact) -> some View {
        ContactView(contact: contact)
    }
    
    private func addEntry() -> AnyView {
        AnyView(ContactForm(contact: Contact(), formMode: .adding))
    }
}

#if DEBUG
struct ContactEntry_Previews: PreviewProvider {
    static var previews: some View {
        ContactEntry()
    }
}
#endif
