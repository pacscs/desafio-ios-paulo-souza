//
//  ModelComic.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import UIKit
import Foundation

struct MarvelComics: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: MarvelComicsData?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case etag = "etag"
        case data = "data"
    }
}
struct MarvelComicsData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [MarvelComicsResult]?
    
    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}
struct MarvelComicsResult: Codable {
    var id: Int?
    var digitalID: Int?
    var title: String?
    var issueNumber: Int?
    var `variantDescription`: String?
    var `resultDescription`: String?
    var modified: String?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String?
    var pageCount: Int?
    var textObjects: [MarvelComicsTextObject]?
    var resourceURI: String?
    var urls: [MarvelComicsURL]?
    var series: MarvelComicsSeries?
    var variants: [MarvelComicsSeries]?
    var collections: [MarvelComicsSeries]?
    var collectedIssues: [MarvelComicsSeries]?
    var dates: [MarvelComicsDate]?
    var prices: [MarvelComicsPrice]?
    var thumbnail: MarvelComicsThumbnail
    var images: [MarvelComicsThumbnail]?
    var creators: MarvelComicsCreators?
    var characters: MarvelComicsCharacters?
    var stories: MarvelComicsStories?
    var events: MarvelComicsCharacters?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case digitalID = "digitalId"
        case title = "title"
        case issueNumber = "issueNumber"
        case `variantDescription` = "variantDescription"
        case `resultDescription` = "description"
        case modified = "modified"
        case isbn = "isbn"
        case upc = "upc"
        case diamondCode = "diamondCode"
        case ean = "ean"
        case issn = "issn"
        case format = "format"
        case pageCount = "pageCount"
        case textObjects = "textObjects"
        case resourceURI = "resourceURI"
        case urls = "urls"
        case series = "series"
        case variants = "variants"
        case collections = "collections"
        case collectedIssues = "collectedIssues"
        case dates = "dates"
        case prices = "prices"
        case thumbnail = "thumbnail"
        case images = "images"
        case creators = "creators"
        case characters = "characters"
        case stories = "stories"
        case events = "events"
    }
    
    init (id: Int? = nil,
          digitalID: Int?  = nil,
          title: String?  = nil,
          issueNumber: Int?  = nil,
          variantDescription: String? = nil,
          resultDescription: String? = nil,
          modified: String? = nil,
          isbn: String? = nil,
          upc: String? = nil,
          diamondCode: String? = nil,
          ean: String? = nil,
          issn: String? = nil,
          format: String? = nil,
          pageCount: Int? = nil,
          textObjects: [MarvelComicsTextObject]? = nil,
          resourceURI: String? = nil,
          urls: [MarvelComicsURL]? = nil,
          series: MarvelComicsSeries? = nil,
          variants: [MarvelComicsSeries]? = nil,
          collections: [MarvelComicsSeries]? = nil,
          collectedIssues: [MarvelComicsSeries]? = nil,
          dates: [MarvelComicsDate]? = nil,
          prices: [MarvelComicsPrice]? = nil,
          thumbnail: MarvelComicsThumbnail,
          images: [MarvelComicsThumbnail]? = nil,
          creators: MarvelComicsCreators? = nil,
          characters: MarvelComicsCharacters? = nil,
          stories: MarvelComicsStories? = nil,
          events: MarvelComicsCharacters? = nil) {
        self.id = id
        self.title = title
        self.issueNumber = issueNumber
        self.variantDescription = variantDescription
        self.resultDescription = resultDescription
        self.modified = modified
        self.isbn = isbn
        self.upc = upc
        self.diamondCode = diamondCode
        self.ean = ean
        self.issn = issn
        self.format = format
        self.pageCount = pageCount
        self.textObjects = textObjects
        self.resourceURI = resourceURI
        self.urls = urls
        self.series = series
        self.variants = variants
        self.collections = collections
        self.collectedIssues = collectedIssues
        self.dates = dates
        self.prices = prices
        self.thumbnail = thumbnail
        self.images = images
        self.creators = creators
        self.characters = characters
        self.stories = stories
        self.events = events
    }
}

struct MarvelComicsCharacters: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelComicsSeries]?
    var returned: Int?
    
    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

struct MarvelComicsSeries: Codable {
    var resourceURI: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }
}

struct MarvelComicsCreators: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelComicsCreatorsItem]?
    var returned: Int?
    
    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

struct MarvelComicsCreatorsItem: Codable {
    var resourceURI: String?
    var name: String?
    var role: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
        case role = "role"
    }
}

struct MarvelComicsDate: Codable {
    var type: String?
    var date: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case date = "date"
    }
}

struct MarvelComicsThumbnail: Codable {
    var path: String?
    var `extension`: String?
    var image: Observable<UIImage> = Observable(UIImage())
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case `extension` = "extension"
    }
    
    init(path: String? = nil,
         extension: String? = nil,
         image: UIImage) {
        self.path = path
        self.extension = `extension`
        self.image = Observable(image)
    }
    
    init (image: UIImage) {
        self.image = Observable(image)
    }
    
    func pathString() -> String {
        guard let path = self.path, let ext = self.extension else { return String() }
        return "\(path).\(ext)"
    }
    
}

struct MarvelComicsPrice: Codable {
    var type: String?
    var price: Double?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case price = "price"
    }
}

struct MarvelComicsStories: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelComicsStoriesItem]?
    var returned: Int?
    
    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

struct MarvelComicsStoriesItem: Codable {
    var resourceURI: String?
    var name: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
        case type = "type"
    }
}

struct MarvelComicsTextObject: Codable {
    var type: String?
    var language: String?
    var text: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case language = "language"
        case text = "text"
    }
}

struct MarvelComicsURL: Codable {
    var type: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}

