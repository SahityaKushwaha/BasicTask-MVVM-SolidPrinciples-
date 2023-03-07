//
//  NotesCVCell.swift
//  Task
//
//  Created by sahitya kushwaha on 08/03/23.
//

import UIKit
import SDWebImage

class NotesCVCell: UICollectionViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var lblProfileBottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        baseView.layer.cornerRadius = 20
        baseView.clipsToBounds = true
//      imageView.layer.cornerRadius = 20
//      visualEffectView.layer.cornerRadius = 20
    }
}

extension NotesCVCell {
    func setupCell(index: Int, model: Invites) {
        lblProfileBottomConstraint.constant = 33
        visualEffectView.isHidden = true
        let profileUrl = URL(string: model.profiles?[index].photos?.first?.photo ?? "")
        imageView.sd_setImage(with: profileUrl, placeholderImage: nil, options: [.refreshCached]) { image, error, cache, url in
            self.imageView.image = image
        }
        lblProfileName.font = UIFont.boldSystemFont(ofSize: 24)
        lblProfileName.text = (model.profiles?[index].general_information?.first_name ?? "") + ", " + "\(model.profiles?[index].general_information?.age ?? 0)"
    }
    
    func setupLikesCell(index: Int, model: Likes) {
        lblProfileBottomConstraint.constant = 20
        let profileUrl = URL(string: model.profiles?[index].avatar ?? "")
        imageView.sd_setImage(with: profileUrl, placeholderImage: nil, options: [.refreshCached]) { image, error, cache, url in
            self.imageView.image = image
        }
        lblProfileName.font = UIFont.boldSystemFont(ofSize: 20)
        lblProfileName.text = model.profiles?[index].first_name ?? ""
        lblInfo.isHidden = true
        
        if !(model.can_see_profile ?? false) {
            visualEffectView.isHidden = false
            visualEffectView.effect = UIBlurEffect(style: .dark)
            visualEffectView.alpha = 0.8
        }
    }
}
