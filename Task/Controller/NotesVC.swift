//
//  NotesVC.swift
//  Task
//
//  Created by sahitya kushwaha on 08/03/23.
//

import UIKit

class NotesVC: BaseVC {

    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var likesCollectionView: UICollectionView!
    @IBOutlet weak var upgradeBtn: UIButton!
    
    var viewModel: NotesVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    /**
     This getInstance() function is about to get the VC Screen reference from Storyboard. */
    static func getInstance()->NotesVC? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "NotesVC") as? NotesVC
    }
    deinit {
        debugPrint("\(self) :: No Memory Leak")
    }
    
    func setupVC() {
        registerCell()
        upgradeBtn.layer.cornerRadius = 25
        
        if viewModel == nil {
            viewModel = NotesVM(ApiHandler())
        }
        
        getProfileListRequest()
    }
    
    func registerCell() {
        profileCollectionView.register(UINib(nibName: "NotesCVCell", bundle: nil), forCellWithReuseIdentifier: "NotesCVCell")
        likesCollectionView.register(UINib(nibName: "NotesCVCell", bundle: nil), forCellWithReuseIdentifier: "NotesCVCell")
    }
}

extension NotesVC {
    func getProfileListRequest() {
        if isInternetAvailale {
            self.showLoader()
            self.viewModel?.getNotesRequest({ response in
                self.hideLoader()
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                        self.profileCollectionView.reloadData()
                        self.likesCollectionView.reloadData()
                    }
                }
            })
        } else {
            Alert.shared.toastWithOneBtn("", INTERNET_CONNECTION_ERROR, btnName: OK) { (_) in
                
            }
        }
    }
}
