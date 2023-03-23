//
//  RealmListFavoriteGroup.swift
//  Personal Relationship Management
//
//  Created by Taylor Geisse on 3/20/23.
//

import SwiftUI
import RealmSwift

struct RealmListFavoriteGroup<RealmObject: Object & Identifiable & CanBeFavorited, RowView: View>: View {
    
    @ObservedResults(RealmObject.self, where: { $0.isFavorite == true }) private var favorites
    @ObservedResults(RealmObject.self) private var allItems
    
    /*
    @ObservedSectionedResults(RealmObject.self,
                              sectionKeyPath: \.isFavorite,
                              sortDescriptors: [SortDescriptor(keyPath: "isFavorite", ascending: false)]) var listItems
     */
    
    var pluralTitle: String
    @Binding var selectedItem: RealmObject?
    var rowView: (RealmObject) -> RowView
    
    var body: some View {
        List(selection: $selectedItem) {
            if allItems.isEmpty {
                Text("No \(pluralTitle) here!")
            } else {
                // favorites section first
                Section("Favorites") {
                    ForEach(favorites, id: \.self) { item in
                        rowView(item)
                    }
                    .onDelete(perform: $favorites.remove)
                }
                
                // all items section second
                Section("All \(pluralTitle)") {
                    ForEach(allItems, id: \.self) { item in
                        rowView(item)
                    }
                    .onDelete(perform: $allItems.remove)
                }
            }
            
            /*
            ForEach(listItems) { section in
                Section(header: Text(section.key == true ? "Favorites" : "")) {
                    ForEach(section, id: \.self) { item in
                        rowView(item)
                    }
                    //.onDelete { remove(sectionKey: section.key, atIndex: $0) }
                }
            }
             */
        }
        .navigationTitle(pluralTitle)
       // .listStyle(.grouped)
    }
    
    private func remove(sectionKey: Bool, atIndex: IndexSet?) {
        // TODO: provide support for deleting an object in the section results; not sure it is supported as ObservedResults
        return
        
        /*
         guard let indexSet = atIndex else { return }
         
         var sectionIndex: Int = -1
         
         for (idx, section) in listItems.enumerated() {
         if section.key == sectionKey { sectionIndex = idx }
         }
         
         if sectionIndex == -1 { return }
         
         for index in indexSet {
         let itemToDelete = listItems[sectionIndex][index]
         let idToDelete = itemToDelete.value(forKey: "_id")
         
         if itemToDelete.isSameObject(as: selectedItem) {
         selectedItem = nil
         }
         
         DebugUtil.print("ID of item: \(idToDelete)")
         DebugUtil.print("Will delete contact: \(itemToDelete)")
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
         let realm = try! Realm()
         guard let localObject = realm.object(ofType: RealmObject.self, forPrimaryKey: idToDelete) else { return }
         print(localObject.isFrozen)
         try! realm.write {
         realm.delete(localObject)
         }
         }
         }
         */
        /*
         let itemToDelete = listItems[favoriteSection ? 0 : 1][index]
         
         let realm = itemToDelete.realm!
         
         DebugUtil.print("Will delete contact: \(itemToDelete)")
         
         if itemToDelete.id == selectedItem?.id {
         selectedItem = nil
         }
         
         let thawedItem = itemToDelete.thaw()
         
         if thawedItem?.isInvalidated == false {
         let thawedRealm = thawedItem!.realm!
         
         try! thawedRealm.write {
         thawedRealm.delete(itemToDelete)
         }
         }
         */
    }
}

#if DEBUG
struct RealmListFavoriteGroup_Previews: PreviewProvider {
    static var previews: some View {
        RealmListFavoriteGroup(pluralTitle: "Contacts",
                               selectedItem: .constant(nil),
                               rowView: { (c: Contact) in Text(c.fullName) })
    }
}
#endif
