//
//  Date+Ext.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 14/05/22.
//

import Foundation


extension Date {
    func ddMmYy() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}
