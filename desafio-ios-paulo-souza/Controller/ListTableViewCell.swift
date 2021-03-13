//
//  ListTableViewCell.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    

    
    @IBOutlet weak var viewIcon: UIView!
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(character: inout MarvelCharacters) {
        self.lblTitle.text = character.name
        self.viewIcon.layer.cornerRadius = self.imgIcon.frame.width / 2
        self.imgIcon.layer.cornerRadius = self.imgIcon.frame.width / 2
        self.imgIcon.layer.masksToBounds = true
        self.imgIcon.layer.borderColor = UIColor.white.cgColor
        self.imgIcon.layer.borderWidth = 4
        self.setupImage(character: character)
        self.accessibilityTraits = .button
        self.accessibilityHint = "double tap do see more details"
    }
    
    func setupImage(character: MarvelCharacters) {
        self.progress.isAccessibilityElement = false
        self.viewIcon.dropShadow()
        self.progress.startAnimating()
        if let image = Service.shared.readImage(type: .avatar, withFileName: character.thumbnail.pathString()) {
            self.progress.stopAnimating()
            self.imgIcon.image = image
        } else {
            Service.shared.downloadAvatar(from: character.thumbnail.path, with: character.thumbnail.extension, callBack: { (image) in
                DispatchQueue.main.async {
                    self.progress.stopAnimating()
                    self.imgIcon.image = image
                }
            }, callBackError: {
                DispatchQueue.main.async {
                    self.progress.stopAnimating()
                    self.imgIcon.image = #imageLiteral(resourceName: "placeholder.png")
                }
            })
        }
    }
    
    override func prepareForReuse() {
        self.imgIcon.image = nil
        self.lblTitle.text = nil
    }
    
}
