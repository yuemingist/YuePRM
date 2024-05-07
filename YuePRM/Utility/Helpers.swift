//
//  Helpers.swift
//  YuePRM
//
//  Created by yueming on 2024/4/23.
//

import Foundation

// todo: app内切换语言

extension String {
    var localized: String {
        localized(comment: "")
    }

    func localized(comment: String) -> String {
        NSLocalizedString(self, comment: comment)
    }

    func localized(comment: String = "", arguments: CVarArg...) -> String {
        String(format: localized(comment: ""), arguments: arguments)
    }
}

