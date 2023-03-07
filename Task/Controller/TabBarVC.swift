//
//  TabVC.swift
//
//
//  Created by sahitya kushwaha on 08/03/23.
//

import UIKit

class TabBarVC: UITabBarController {
    
    var Homebtn : UITabBarItem!
    var Scan : UITabBarItem!
    var MyWallet : UITabBarItem!
    var Account : UITabBarItem!
    
    let layerGradient = CAGradientLayer()
    var selectIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTabIcons()
        self.selectedIndex = 1
    }
    
    /**
     This getInstance() function is about to get the VC Screen reference from Storyboard. */
    static func getInstance()->TabBarVC? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
    }
    deinit {
        debugPrint("\(self) :: No Memory Leak")
    }
}

extension TabBarVC {
    
    // Setting Tabs item icons
    func updateTabIcons() {
        
        Homebtn = UITabBarItem()
        Scan = UITabBarItem()
        MyWallet  =  UITabBarItem()
        Account  =  UITabBarItem()
        
        let tab = self.viewControllers
        let discover = tab?[0].tabBarItem
        let notes = tab?[1].tabBarItem
        let matches = tab?[2].tabBarItem
        let profile = tab?[3].tabBarItem
        
        appIcons(item: discover!, normal : "tab_discover", selected : "tab_discover")
        appIcons(item: notes!, normal : "tab_notes", selected : "tab_notes")
        appIcons(item: matches!,normal : "tab_matches", selected : "tab_matches")
        appIcons(item: profile!, normal : "tab_profile", selected : "tab_profile")
        
        let titleColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        /** updating TabIcons Text while Normal & Selection */
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [TabBarVC.self])
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor], for: .normal)
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor], for: .selected)
    }
    
    // A common function is about to manage the tab item icon
    func appIcons(item : UITabBarItem, normal : String, selected : String) {
        item.image = UIImage(named: normal)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        item.selectedImage = UIImage(named: selected)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
}

