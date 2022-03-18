//
//  TimeFormat.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import Foundation

func calcuTime(date:Date) -> String {
    let mints = Int(-date.timeIntervalSinceNow)/60
    let hours = mints/24
    let days = hours/24

    if mints <= 2 {
        return "just now"
    } else if mints < 60  && mints > 2 {
        return "\(mints) mins ago"
    } else if mints > 60 && hours < 24 {
        return "\(hours) hours ago"
    } else if hours > 24 && hours < 48 {
        return "1 day ago"
    } else {
        return "\(days) days ago"
    }
}


