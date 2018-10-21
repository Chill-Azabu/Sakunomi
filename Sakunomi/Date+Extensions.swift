
import UIKit

extension Date {
    func monthAgoDate() -> Date {
        let addValue = -1
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents, to: self)!
    }
    
    func monthLaterDate() -> Date {
        let addValue: Int = 1
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents, to: self)!
    }
    
    //前月の表示
    func prevMonth(date: Date) ->Date {
        let selectedDate = date.monthAgoDate()
        return selectedDate
    }
    //次月の表示
    func nextMonth(date: Date) -> Date {
        let selectedDate = date.monthLaterDate()
        return selectedDate
    }
}
