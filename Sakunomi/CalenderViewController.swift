import RxSwift
import UIKit

class CalenderViewController: UIViewController {

    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    @IBOutlet weak var prevBtn: UIBarButtonItem!
    @IBOutlet weak var nextBtn: UIBarButtonItem!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        calenderCollectionView.backgroundColor = .white
        
        bindBarButtonItems()
    }

    private func bindBarButtonItems() {
        
    }
    
}

extension CalenderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewLayout {

}
