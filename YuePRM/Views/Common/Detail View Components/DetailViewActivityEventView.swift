//
//  DetailViewActivityEventView.swift
//  Personal Relationship Management
//
//  Created by Taylor Geisse on 3/22/23.
//

import SwiftUI

struct DetailViewActivityEventView: View {
    var title: String
    var date: Date
    var note: String
    var type: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                ContactNameLabel(contact: Contact(value: ["firstName": "Taylor", "lastName": "Geisse", "title": "老板"]))
                
                HStack(spacing: 4) {
                    Text(date.stringFormat(.shortDate))
                    
                    Text("⬩")
                    
                    Text(type)
                }
                .opacity(0.7)
                
                Spacer()
                    .frame(height: 5)
                
                Text(note)
            }
            
        }
    }
}

struct ContactNameLabel: View {
    var contact: Contact
    
    var body: some View {
        Label {
            Text(contact.fullName)
                .font(.body)
                .foregroundColor(.primary)
            Text(contact.title)
                .font(.subheadline)
                .foregroundColor(.secondary)
        } icon: {
            Circle()
                .fill(Color.purple)
                .frame(width: 44, height: 44, alignment: .center)
                .overlay(Text(contact.initials).foregroundColor(.white))
        }
    }
}

struct DetailViewActivityEventView_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewActivityEventView(title: Activity.activity1.title,
                                    date: Activity.activity1.date,
                                    note: Activity.activity1.notes,
                                    type: Activity.activity1.type.rawValue)
    }
}
