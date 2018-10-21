
import Foundation
import UIKit

struct CalendarViewModel {
    var currentMonthOfDates = [Date]() //表記する月の配列
    var selectedDate = NSDate()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!
    
    //月ごとのセルの数を返すメソッド
    mutating func daysAcquisition() -> Int {
        let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth() as Date)
        let numberOfWeeks = rangeOfWeeks?.count //月が持つ週の数
        numberOfItems = numberOfWeeks! * daysPerWeek //週の数×列の数
        return numberOfItems
    }
    //月の初日を取得
    func firstDateOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate as Date)
        components.day = 1
        let firstDateMonth = Calendar.current.date(from: components)
        return firstDateMonth!
    }
    
    // ⑴表記する日にちの取得
    mutating func dateForCellAtIndexPath(numberOfItems: Int) {
        // ①「月の初日が週の何日目か」を計算する
        guard let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth() as Date) else { return }
        for i in 0..<numberOfItems {
            // ②「月の初日」と「indexPath.item番目のセルに表示する日」の差を計算する
            var dateComponents = DateComponents()
            dateComponents.day = i - (ordinalityOfFirstDay - 1)
            // ③ 表示する月の初日から②で計算した差を引いた日付を取得
            guard let date = Calendar.current.date(byAdding: dateComponents, to: firstDateOfMonth() as Date) else { return }
            // ④配列に追加
            currentMonthOfDates.append(date)
        }
    }
    
    // ⑵表記の変更
    mutating func conversionDateFormat(indexPath: IndexPath) -> String {
        dateForCellAtIndexPath(numberOfItems: numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row] as Date)
    }
}
