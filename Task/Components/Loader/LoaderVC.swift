
/**
 Class Name        :          LoaderVC.Swift
 Created On        :           08/03/23.
 Developed By        :       Sahitya Kushwaha
 
 Description: This class is about show to loader view.   */

import UIKit

public class LoaderVC: UIViewController {
    @IBOutlet weak var baseView: UIView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    /** Basic initialization for this view controller. */
    func setupVC(){
        logInfo("\(self) :: Memory Initialized")
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissScreen))
        self.baseView.addGestureRecognizer(tap)
        
    }
     
    /** Basic initialization for this view controller. */
    public static func getInstance() -> LoaderVC? {
        let storyBoard = UIStoryboard(name: "LoaderSt", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "LoaderVC") as? LoaderVC
    }
    
    
    @objc public func dismissScreen() {
        self.dismiss(animated: false, completion: nil)
    }
    
    /**
     Memory Leak issue will be notified. If this viewcontroller will have memory leak, then it will enter in deinit {}
     */
    deinit {
        logInfo("\(self) :: No Memory Leak")
    }
}

var _loadingView: LoaderVC?

public extension UIViewController {
    
    /** Show Loader */
    func showLoader(_ text:String = "") {
        _loadingView = LoaderVC.getInstance()
        if let loader = _loadingView {
            self.view.addSubview(loader.view)
        }
    }
    
    /** Hide Loader */
    func hideLoader() {
        if let loader = _loadingView {
            loader.view.removeFromSuperview()
            _loadingView = nil
        }
    }
}
