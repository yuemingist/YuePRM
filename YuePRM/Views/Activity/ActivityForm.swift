//
//  ActivityForm.swift
//  YuePRM
//
//  Created by yueming on 2024/4/24.
//

import SwiftUI
import RealmSwift

struct ActivityForm: View {
    @ObservedRealmObject var activity: Activity
    var formMode: FormMode
    
    @ObservedResults(Contact.self) private var contacts
    @State private var selectedContact: Contact?
    @Environment(\.realm) private var realm
    
   // @Environment(\.horizontalSizeClass) private var horizontalSize
    
    init(activity: Activity, formMode: FormMode) {
        self.formMode = formMode
        
        if activity.isFrozen {
            DebugUtil.print("Thawing the activity")
            self.activity = activity.thaw()!
        } else {
            self.activity = activity
        }
    }
    
    var body: some View {
        NavigationView {
            activityForm
                .cancelSaveDoneToolbar(formMode: formMode, object: activity)
        }
    }
    
    private var activityForm: some View {
        Form {
            TextFieldWithLabel("title", text: $activity.title)
//            TextFieldWithLabel("date", text: $activity.date)
            TextFieldWithLabel("Notes", text: $activity.notes)
                //.lineLimit(horizontalSize == .compact ? 8 : 5)
            
            Button("这里负责选择contact") {
                try! realm.write {
                    let person = realm.objects(Contact.self).filter("firstName = 'John'")
                    activity.setValue(person, forKey: "contacts")
                }
                
                
                
            }
            
//            ForEach(contacts, id: \.self) { item in
//                Text(item.fullName)
//            }
//            
//            Picker("Contact", selection: $selectedContact) {
//                ForEach(contacts) { item in
//                    Text(item.fullName)
//                }
//            }
//            .onReceive(selectedContact.publisher.first()) { value in
//                activity.setValue(value, forKey: "contact")
//            }
        }
        
    }
}

#if DEBUG
struct ActivityForm_Previews: PreviewProvider {
    static var previews: some View {
        ActivityForm(activity: Activity.activity1, formMode: .editing)
    }
}
#endif
