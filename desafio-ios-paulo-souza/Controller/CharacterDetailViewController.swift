//
//  CharacterViewController.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import UIKit

class CharacterViewController: BaseViewController {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var viewIcon: UIView!
    @IBOutlet weak var stackViewName: UIStackView!
    @IBOutlet weak var labelTitleName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var stackViewDescription: UIStackView!
    @IBOutlet weak var labelTitleDescription: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonDescription: UIButton!
    @IBOutlet weak var buttonMagazine: UIButton!
    @IBOutlet weak var progressActivity: UIActivityIndicatorView!
    
    var character: MarvelCharactersResult
    var loading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                switch self.loading {
                case true:
                    self.progressActivity.startAnimating()
                    UIAccessibility.post(notification: .announcement, argument: "loading. please wait")
                case false:
                    self.progressActivity.stopAnimating()
                    UIAccessibility.post(notification: .announcement, argument: "load done")
                }
            }
        }
    }
    
    required init(character: MarvelCharactersResult) {
        self.character = character
        super.init(nibName: "CharacterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accessibilityElements = [self.stackViewName!, self.stackViewDescription!, self.buttonMagazine!]
        if let name = self.character.name {
            self.title = name
            self.navigationItem.titleView?.accessibilityLabel = name
        } else {
            self.title = "character detail"
            self.navigationItem.titleView?.accessibilityLabel = "character detail"
        }
        self.setupView()
    }
    
    func setupView() {
        self.progressActivity.isAccessibilityElement = false
        if let image = Service.shared.readImage(type: .avatar, withFileName: self.character.thumbnail.pathString()) {
            self.imageIcon.image = image
            self.viewIcon.dropShadow()
            self.imageIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:))))
            self.viewIcon.isHidden = false
            self.viewIcon.isAccessibilityElement = false
            self.imageIcon.isAccessibilityElement = false
        } else {
            self.viewIcon.isHidden = true
        }
        if let name = self.character.name, !name.isEmpty {
            self.labelTitleName.text = "Name: "
            self.labelName.text = name
            self.stackViewName.isHidden = false
            self.stackViewName.isAccessibilityElement = true
            self.stackViewName.accessibilityLabel = "Name: \(name)"
        } else {
            self.stackViewName.isHidden = true
        }
        if let description = self.character.description, !description.isEmpty {
            self.labelTitleDescription.text = "Description: "
            self.labelDescription.text = description
            self.stackViewDescription.isHidden = false
            self.stackViewDescription.isAccessibilityElement = true
            self.stackViewDescription.accessibilityLabel = "description: \(description)"
        } else {
            self.stackViewDescription.isHidden = true
        }
        self.buttonMagazine.setTitle("check my higher price!!", for: .normal)
        self.buttonMagazine.setTitleColor(UIColor.systemBlue, for: .normal)
        self.buttonMagazine.layer.borderColor = UIColor.systemBlue.cgColor
        self.buttonMagazine.layer.borderWidth = 4
        self.buttonMagazine.layer.cornerRadius = 10
        self.buttonMagazine.layer.masksToBounds = true
        self.buttonMagazine.accessibilityHint = "load the higher price magazine for this hero"
    }
    
    func task(id: String) {
        self.loading = true
        Service.shared.taskComics(id: id, callbackSuccess: { (comics) in
            self.handleResult(comics: comics)
        }, callbackError: { (error) in
            self.loading = false
            DispatchQueue.main.async {
                self.alert(title: "Sorry!", message: "There's an error loading. Please, try again later")
            }
            print(error ?? "erro desconhecido")
        })
    }
    
    func handleResult(comics: MarvelComicsData) {
        if let results = comics.results {
            if results.count > 0 {
                if let comic = results.sorted(by: { (comic1, comic2) -> Bool in
                    guard let price1 = comic1.prices?.first?.price, let price2 = comic2.prices?.first?.price else { return false }
                    return price1 > price2
                }).first {
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(ComicViewController(comic: comic), animated: true)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.alert(title: "Sorry!", message: "No issues found for this character :(")
                }
            }
        }
        self.loading = false
    }
    
    @IBAction func btnDescription(_ sender: UIButton) {
        self.labelDescription.numberOfLines = self.labelDescription.numberOfLines == 3 ? 0 : 3
    }

    @IBAction func btnMagazine(_ sender: UIButton) {
        if !self.loading {
            if fake {
                if let responseComics = Service.shared.loadJson(type: MarvelComics.self, filename: "responseComics"), let comics = responseComics.data {
                    self.handleResult(comics: comics)
                }
            } else {
                if let id = self.character.id {
                    self.task(id: String(id))
                }
            }
        }
    }
    
    @objc
    func imageTapped(_ sender: UITapGestureRecognizer) {
        if let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first,
            let imageView = self.imageIcon,
            let image = imageView.image {
            let bgView = UIView()
            bgView.frame = keyWindow.frame
            bgView.backgroundColor = .systemBackground
            bgView.alpha = 0
            bgView.tag = 1703
            bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage)))
            keyWindow.addSubview(bgView)
            let newView = UIView()
            newView.frame = self.viewIcon.convert(self.viewIcon.frame, to: nil)
            newView.backgroundColor = UIColor.white
            newView.layer.masksToBounds = true
            newView.tag = 1704
            newView.dropShadow()
            newView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage)))
            keyWindow.addSubview(newView)
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = CGRect(x: 0, y: 0, width: self.viewIcon.frame.size.width, height: self.viewIcon.frame.size.height)
            newImageView.backgroundColor = .clear
            newImageView.contentMode = .scaleAspectFill
            newImageView.layer.masksToBounds = true
            newImageView.tag = 1705
            newImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage)))
            newView.addSubview(newImageView)
            self.viewIcon.alpha = 0
            self.imageIcon.alpha = 0
            UIView.animate(withDuration: 0.75, animations: {
                let wView = UIScreen.main.bounds.width
                let hView = (image.size.height * wView) / image.size.width
                newView.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height / 2) - (hView / 2), width: wView, height: hView)
                let wImage = UIScreen.main.bounds.width
                let hImage = (image.size.height * wImage) / image.size.width
                newImageView.frame = CGRect(x: 0, y: 0, width: wImage, height: hImage)
                bgView.alpha = 1
            })
        }
    }

    @objc
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        if let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first,
            let bgView = keyWindow.subviews.first(where: { $0.tag == 1703}),
            let newView = keyWindow.subviews.first(where: { $0.tag == 1704}),
            let newImageView = newView.subviews.first(where: { $0.tag == 1705}) {
            UIView.animate(withDuration: 0.75, animations: {
                newView.frame = self.viewIcon.convert(self.viewIcon.frame, to: nil)
                newImageView.frame.size = CGSize(width: self.imageIcon.frame.size.width, height: self.imageIcon.frame.size.height)
                bgView.alpha = 0
            }, completion: { (_) in
                self.viewIcon.alpha = 1
                self.imageIcon.alpha = 1
                bgView.removeFromSuperview()
                newView.removeFromSuperview()
                newImageView.removeFromSuperview()
            })
        }
    }
    
}
