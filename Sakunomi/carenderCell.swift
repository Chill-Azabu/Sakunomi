
import UIKit

protocol MonthViewDelegate: class {
    func didChangeMonth(monthIndex: Int, year:Int)
}

struct MonthArray {
    let Janualy: String
    let february: String
    let march: String
    let April: String
    let may: String
    let june: String
    let july: String
    let august: String
    let september: String
    let october: String
    let november: String
    let december: String
}

class MonthView: UIView {
    
    var currentMonthIndex = 0
    var currentYearIndex = 0
    var delegate: MonthViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYearIndex = Calendar.current.component(.year, from: Date())
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
    }
}
