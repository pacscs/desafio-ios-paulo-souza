//
//  ListTableViewCell.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    

    
    @IBOutlet weak var viewIcon: UIView!
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var progressActivity: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(character: inout MarvelCharactersResult) {
        self.labelTitle.text = character.name
        self.setupImage(character: character)
    }
    
    func setupImage(character: MarvelCharactersResult) {
        self.progressActivity.isAccessibilityElement = false
        self.viewIcon.dropShadow()
        self.progressActivity.startAnimating()
        if let image = Service.shared.readImage(type: .avatar, withFileName: character.thumbnail.pathString()) {
            self.progressActivity.stopAnimating()
            self.imageIcon.image = image
        } else {
            Service.shared.downloadAvatar(from: character.thumbnail.path, with: character.thumbnail.extension, callBack: { (image) in
                DispatchQueue.main.async {
                    self.progressActivity.stopAnimating()
                    self.imageIcon.image = image
                }
            }, callBackError: {
                DispatchQueue.main.async {
                    self.progressActivity.stopAnimating()
                    self.imageIcon.image = #imageLiteral(resourceName: "placeholder.png")
                }
            })
        }
    }
    
    override func prepareForReuse() {
        self.imageIcon.image = nil
        self.labelTitle.text = nil
    }
    
}
