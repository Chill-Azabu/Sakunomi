
import RxSwift
import RxCocoa
import UIKit

class WalkThroughViewController: UIViewController {

    @IBOutlet weak var outerScrollView: UIScrollView!
    @IBOutlet weak var innerScrollView: UIScrollView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    @IBOutlet weak var deepScrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        outerScrollView.contentInsetAdjustmentBehavior = .never
        
        outerScrollView.rx.contentOffset
            .subscribe(onNext: { [weak self] in
                guard let innerScrollView = self?.innerScrollView, let deepScrollView = self?.deepScrollView else {
                    return
                }
                
                innerScrollView.contentOffset.x = min($0.x, innerScrollView.bounds.width)
                
                let factor = deepScrollView.bounds.width / innerScrollView.bounds.width
                let offsetX = max(0, min(($0.x - innerScrollView.bounds.width) * factor,
                                         deepScrollView.contentSize.width - deepScrollView.bounds.width))
                deepScrollView.contentOffset.x = offsetX
            }).disposed(by: disposeBag)
        
        outerScrollView.rx.currentPage
            .subscribe(onNext: { [weak self] in
                self?.pageControll.currentPage = $0
            }).disposed(by: disposeBag)
        
        pageControll.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let currentPage = self?.pageControll.currentPage else { return }
                self?.outerScrollView.setCurrentPage(currentPage, animated: true)
            }).disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

private extension Reactive where Base: UIScrollView {
    var currentPage: Observable<Int> {
        return didEndDecelerating.map({
            let pageWidth = self.base.frame.width
            let page = floor((self.base.contentOffset.x - pageWidth / 2) / pageWidth) + 1
            return Int(page)
        })
    }
}

private extension UIScrollView {
    func setCurrentPage(_ page: Int, animated: Bool) {
        var rect = bounds
        rect.origin.x = rect.width * CGFloat(page)
        rect.origin.y = 0
        scrollRectToVisible(rect, animated: animated)
    }
}
