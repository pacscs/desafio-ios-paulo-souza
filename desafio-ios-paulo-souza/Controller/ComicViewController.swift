//
//  ComicViewController.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import UIKit

class ComicViewController: BaseViewController {

    @IBOutlet weak var backScrennImage: UIImageView!
    @IBOutlet weak var stackViewImage: UIStackView!
    @IBOutlet weak var viewIcon: UIView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var progressActivity: UIActivityIndicatorView!
    @IBOutlet weak var stackViewTitle: UIStackView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var stackViewDescription: UIStackView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonDescription: UIButton!
    @IBOutlet weak var stackViewPrice: UIStackView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet var cstImageW: NSLayoutConstraint!
    @IBOutlet var cstImageH: NSLayoutConstraint!
    
    var comic: MarvelComicsResult
    
    required init(comic: MarvelComicsResult) {
        self.comic = comic
        super.init(nibName: "ComicViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accessibilityElements = [self.navigationItem.titleView, self.stackViewTitle!, self.stackViewDescription!, self.stackViewPrice!]
        if let issueNumber = self.comic.issueNumber {
            self.title = "#\(issueNumber)"
            self.navigationItem.titleView?.accessibilityLabel = "issue number \(issueNumber)"
        } else {
            self.title = "check my higher price!"
            self.navigationItem.titleView?.accessibilityLabel = "check my higher price!"
        }
        self.setupView()
    }
    
    func setupView() {
        self.progressActivity.isAccessibilityElement = false
        self.stackViewTitle.isAccessibilityElement = true
        self.stackViewDescription.isAccessibilityElement = true
        self.stackViewPrice.isAccessibilityElement = true
        if let title = self.comic.title {
            self.labelTitle.text = title
            self.stackViewTitle.accessibilityLabel = "title: \(title)"
            self.stackViewTitle.isHidden = false
        } else {
            self.stackViewTitle.isHidden = true
        }
        if let resultDescription = self.comic.resultDescription {
            self.labelDescription.text = resultDescription
            self.stackViewDescription.accessibilityLabel = "description: \(resultDescription)"
            self.stackViewDescription.isHidden = false
        } else {
            self.stackViewDescription.isHidden = true
        }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")
        if let prices = self.comic.prices, let first = prices.first, let price = first.price, let priceString = currencyFormatter.string(from: NSNumber(value: price)) {
            self.labelPrice.text = priceString
            self.stackViewPrice.accessibilityLabel = "price: \(priceString)"
            self.stackViewPrice.isHidden = false
        } else {
            self.stackViewPrice.isHidden = true
        }
        self.setupImage()
    }
    
    func setupImage() {
        self.viewIcon.dropShadow()
        self.imageIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:))))
        self.loadImage()
    }
    
    func loadImage() {
        self.progressActivity.startAnimating()
        if let image = Service.shared.readImage(type: .cover, withFileName: self.comic.thumbnail.pathString()) {
            self.populateImage(image: image)
        } else {
            Service.shared.downloadCover(from: self.comic.thumbnail.path, with: self.comic.thumbnail.extension, callBack: { (image) in
                DispatchQueue.main.async {
                    self.populateImage(image: image)
                }
            }, callBackError: {
                DispatchQueue.main.async {
                    self.stackViewImage.isHidden = true
                    self.progressActivity.stopAnimating()
                }
            })
        }
    }
    
    func populateImage(image: UIImage) {
        self.stackViewImage.isHidden = false
        self.progressActivity.stopAnimating()
        self.imageIcon.image = image
        self.cstImageW.constant = 158
        self.cstImageH.constant = (image.size.height * 158) / image.size.width
    }

    @IBAction func btnDescription(_ sender: UIButton) {
        self.labelDescription.numberOfLines = self.labelDescription.numberOfLines == 3 ? 0 : 3
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
            bgView.tag = 1705
            bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage)))
            keyWindow.addSubview(bgView)
            let newView = UIView()
            newView.frame = self.viewIcon.convert(self.viewIcon.frame, to: nil)
            newView.backgroundColor = UIColor.white
            newView.layer.masksToBounds = true
            newView.tag = 1706
            newView.dropShadow()
            newView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage)))
            keyWindow.addSubview(newView)
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = CGRect(x: 0, y: 0, width: self.viewIcon.frame.size.width, height: self.viewIcon.frame.size.height)
            newImageView.backgroundColor = .clear
            newImageView.contentMode = .scaleAspectFill
            newImageView.layer.masksToBounds = true
            newImageView.tag = 1707
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
            let bgView = keyWindow.subviews.first(where: { $0.tag == 1705}),
            let newView = keyWindow.subviews.first(where: { $0.tag == 1706}),
            let newImageView = newView.subviews.first(where: { $0.tag == 1707}) {
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

