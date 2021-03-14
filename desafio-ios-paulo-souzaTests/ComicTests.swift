//
//  Comic.swift
//  desafio-ios-paulo-souzaTests
//
//  Created by Paulo Alfredo Coraini de Souza on 14/03/21.
//

import XCTest
@testable import desafio_ios_paulo_souza

class ComicTests: XCTestCase {
    let controller: ComicViewController = ComicViewController(comic: MarvelComicsResult(id: 1, digitalID: 1, title: "#1", issueNumber: 1, variantDescription: "variantDescription", resultDescription: "resultDescription", modified: "modified", isbn: "isbn", upc: "upc", diamondCode: "diamondCode", ean: "ean", issn: "issn", format: "format", pageCount: 1, thumbnail: MarvelComicsThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp", extension: "png", image: UIImage())))
    
    let testCharacter = MarvelComicsResult(id: 1, digitalID: 1, title: "title", issueNumber: 1, variantDescription: "variantDescription", resultDescription: "resultDescription", modified: "modified", isbn: "isbn", upc: "upc", diamondCode: "diamondCode", ean: "ean", issn: "issn", format: "format", pageCount: 1, thumbnail: MarvelComicsThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp", extension: "png", image: UIImage()))
    
    override func setUp() {
        self.controller.loadViewIfNeeded()
    }

    override func tearDown() {
        self.controller.comic = self.testCharacter
    }
    
    func testComicTitle() {
        XCTAssertEqual(self.controller.title, self.controller.comic.title)
    }
    
    func testComicDescription() {
        self.controller.comic.title = nil
        self.controller.comic.resultDescription = nil
        self.controller.setupView()
        XCTAssertTrue(self.controller.viewIcon.isOpaque)
        XCTAssertTrue(self.controller.stackViewTitle.isHidden)
        XCTAssertTrue(self.controller.stackViewDescription.isHidden)
    }
    
    func testSetUpView() {
        self.controller.setupView()
        XCTAssertTrue(self.controller.viewIcon.isOpaque)
        XCTAssertFalse(self.controller.stackViewTitle.isHidden)
        XCTAssertFalse(self.controller.stackViewDescription.isHidden)
    }
    
    func testLabelDescriptionLine() {
        self.controller.labelDescription.numberOfLines = 0
        XCTAssertEqual(self.controller.labelDescription.numberOfLines, 0)
    }
    
    func testLabelDescriptionLines() {
        self.controller.labelDescription.numberOfLines = 3
        XCTAssertEqual(self.controller.labelDescription.numberOfLines, 3)
    }
}
