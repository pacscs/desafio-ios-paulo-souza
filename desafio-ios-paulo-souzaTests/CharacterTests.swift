//
//  CharacterTests.swift
//  desafio-ios-paulo-souzaTests
//
//  Created by Paulo Alfredo Coraini de Souza on 14/03/21.
//

import XCTest
@testable import desafio_ios_paulo_souza

class CharacterTests: XCTestCase {
    let controller: CharacterViewController = CharacterViewController(character: MarvelCharactersResult(id: 1, name: "name", description: "description", thumbnail: MarvelThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp", extension: "png", image: UIImage())))
    let testCharacter = MarvelCharactersResult(id: 1, name: "name", description: "description",thumbnail: MarvelThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp", extension: "png", image: UIImage()))
    
    override func setUp() {
        self.controller.loadViewIfNeeded()
    }

    override func tearDown() {
        self.controller.character = self.testCharacter
    }
    
    func testCharacterName() {
        XCTAssertEqual(self.controller.title, self.controller.character.name)
    }
    
    func testCharacterDescription() {
        self.controller.character.name = nil
        self.controller.character.description = nil
        self.controller.setupView()
        XCTAssertTrue(self.controller.viewIcon.isOpaque)
        XCTAssertTrue(self.controller.stackViewName.isHidden)
        XCTAssertTrue(self.controller.stackViewDescription.isHidden)
    }
    
    func testSetUpView() {
        self.controller.setupView()
        XCTAssertTrue(self.controller.viewIcon.isOpaque)
        XCTAssertFalse(self.controller.stackViewName.isHidden)
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


