//
//  MainWindowTabs.swift
//  Personal Relationship Management
//
//  Created by Taylor Geisse on 3/20/23.
//

import SwiftUI

/* todo:
 * 1、姓名问题，目前用的是last name和first name，如何兼容中国人和日本的名称？
 * 2、英语的复数问题，目前有不少代码用来区分单数、复数、单转复，如何简化，并支持多语言？
 * 3、当前ios版本16.0，而市面存在20%用户低于这个版本，意味着它们无法使用这个app。
 *    3.1、如果要降级到ios15，那么需要改写NavigationSplitView
 *    3.2、我打算忽略这个问题。ios16发布于22年9年，我培育种子用户时可以放弃低版本用户(依然有80%用户)
 */

enum TabViews: String, CaseIterable, Hashable {
    case activity
    case contacts
    case events
    //case sources
    case settings
    
    var view: AnyView {
        switch self {
        case .activity: return AnyView(ActivityEntry())
        case .contacts: return AnyView(ContactEntry())
        case .events: return AnyView(EventEntry())
        case .settings: return AnyView(SettingsEntry())
        //case .sources: return AnyView(SourcesEntry())
        }
    }
    
    var title: String {
        self.rawValue.capitalized
        
    }
    
    var systemImage: String {
        switch self {
        case .activity: return "person.line.dotted.person.fill"
        case .contacts: return "person.fill"
        case .events: return "calendar"
        case .settings: return "gearshape"
        //case .sources: return "tray.and.arrow.down.fill"
        }
    }
    
    var tag: String { rawValue }
}

struct MainWindowTabs: View {
    @State private var selection: TabViews
    
    init(selection: TabViews = .activity) {
        _selection = State(initialValue: selection)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(TabViews.allCases, id: \.self) { tabView in
                tabView.view
                    .tabItem {
                        Label(tabView.title.localized, systemImage: tabView.systemImage)
                    }
                    .tag(tabView.tag)
            }
        }
    }
}

#if DEBUG
struct MainWindowTabs_Previews: PreviewProvider {
    static var previews: some View {
        MainWindowTabs()
    }
}
#endif
