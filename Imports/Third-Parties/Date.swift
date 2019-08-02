//
//  Date.swift
//  Demo
//
//  Created by David Chen on 7/30/19.
//  Copyright © 2019 David Chen. All rights reserved.
//

import Foundation

var myCalender: Calendar = Calendar.current

let h_day: [Int: String] = [1: "周一", 2: "周二", 3: "周三", 4: "周四", 5: "周五", 6: "周六", 7: "周日"]
let h_uday: [Int: String] = [-1: "昨天", 0: "今天", 1: "明天"]
let h_week: [Int: String] = [0: "上", 1: "", 2: "下"]


func weekOfYear (date: Date) -> Int {
    return myCalender.component(.weekOfYear, from: date)
}

func dayOfWeek (date: Date) -> Int {
    return date.weekday == 1 ? 7 : date.weekday - 1
}

func daysDifference (date1: Date, date2: Date) -> Int {
    // Replace the hour (time) of both dates with 00:00
    let date1 = myCalender.startOfDay(for: date1)
    let date2 = myCalender.startOfDay(for: date2)
    
    return myCalender.dateComponents([.day], from: date1, to: date2).day!
}

func date2Word (date: Date) -> String {
    let uday: Int = daysDifference(date1: Date(), date2: date)
    let nday = dayOfWeek(date: date)
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.dateFormat = " (MM/dd)"
    //let advanced_str: String = (abs(uday) > 1 ? (uday > 1 ? "（\(uday) days later）" : "（\(abs(uday)) days ago）") : "")
    let advanced_str: String = "\(date.year)年\(date.month)月\(date.day)日"
    if (abs(uday) > 14) {
        return advanced_str
    }
    if (abs(uday) < 2) {
        return h_uday[uday]!
    } else if (weekOfYear(date: date) == weekOfYear(date: Date())) {
        return h_day[nday]!
    } else if (abs(weekOfYear(date: date) - weekOfYear(date: Date())) < 2) {
        var str: String = ""
        if (abs(uday) >= 7 || (uday > 0 && nday < dayOfWeek(date: Date())) || (uday < 0 && nday > dayOfWeek(date: Date()))) {
            str = ((uday > 0) ? h_week[2] : h_week[0])!
        }
        str += h_day[nday]!
        return str
    }
    return advanced_str
}
