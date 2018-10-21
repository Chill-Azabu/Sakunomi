import RxSwift
import UIKit

class CalenderViewController: UIViewController {

    @IBOutlet weak var calenderCollectionView: UICollectionView! {
        didSet {
            calenderCollectionView.delegate = self
            calenderCollectionView.dataSource = self
            calenderCollectionView.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var prevBtn: UIBarButtonItem!
    @IBOutlet weak var nextBtn: UIBarButtonItem!
    
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = NSDate()
    var today: NSDate!
    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var viewModel = CalendarViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = setTitle(date: Date())
        bindBarButtonItems()
    }

    private func setTitle(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let selectMonth = formatter.string(from: date)
        return selectMonth
    }
    
    private func bindBarButtonItems() {
        
        prevBtn.rx.tap
            .subscribe(onNext: { [unowned self] in
                selectedDate = Date.prevMonth(selectedDate)
                calenderCollectionView.reloadData()
                navigationItem.title = setTitle(date: selectedDate as Date)
            }).disposed(by: disposeBag)
        nextBtn.rx.tap
            .subscribe(onNext: { [unowned self] in
                selectedDate = Date.nextMonth(selectedDate)
                calenderCollectionView.reloadData()
                navigationItem.title = setTitle(date: selectedDate as Date)
            }).disposed(by: disposeBag)
    }
    
}

extension CalenderViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 曜日を表示するセクションと日付を表示するセクションを表示
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの数を変える.
        if section == 0 {
            return 7
        } else {
            return viewModel.daysAcquisition()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calenderCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalenderViewCell
        
        if (indexPath.row % 7 == 0) {
            cell.calenderElementLabel.textColor = .red
        } else if (indexPath.row % 7 == 6) {
            cell.calenderElementLabel.textColor = .blue
        } else {
            cell.calenderElementLabel.textColor = .gray
        }
        //テキスト配置
        if indexPath.section == 0 {
            cell.calenderElementLabel.text = weekArray[indexPath.row]
        } else {
            cell.calenderElementLabel.text = viewModel.conversionDateFormat(indexPath: indexPath)
            //月によって1日の場所は異なる(後ほど説明します)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CalenderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 1.0
        return CGSize(width: width, height: height)
        
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
}
