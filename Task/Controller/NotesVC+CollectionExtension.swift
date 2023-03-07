//
//  NotesVC+CollectionExtension.swift
//  Task
//
//  Created by sahitya kushwaha on 08/03/23.
//

import UIKit

extension NotesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == profileCollectionView {
            return viewModel?.responseModel?.invites?.profiles?.count ?? 0
        } else {
            return viewModel?.responseModel?.likes?.profiles?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotesCVCell", for: indexPath) as? NotesCVCell else {return UICollectionViewCell()}
        if collectionView == profileCollectionView {
            if let model = viewModel?.responseModel?.invites {
                cell.setupCell(index: indexPath.row, model: model)
            }
        } else {
            if let model = viewModel?.responseModel?.likes {
                cell.setupLikesCell(index: indexPath.row, model: model)
            }
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        if collectionView == profileCollectionView {
            logInfo(size.width - 40)
            logInfo(size.height)
            return CGSize(width: size.width - 40, height: size.height)
        } else {
            let newSize = size.width/2 - 20
            return CGSize(width: newSize, height: size.height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
    }
}
