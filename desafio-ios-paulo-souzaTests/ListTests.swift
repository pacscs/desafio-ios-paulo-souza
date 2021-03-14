//
//  ListTests.swift
//  desafio-ios-paulo-souzaTests
//
//  Created by Paulo Alfredo Coraini de Souza on 14/03/21.
//

import XCTest
@testable import desafio_ios_paulo_souza

class ListTests: XCTestCase {
    
    let cell: ListTableViewCell = Bundle(for: ListTableViewCell.self).loadNibNamed("ListTableViewCell", owner: nil)?.first as! ListTableViewCell
    var testCharacter = MarvelCharactersResult(id: 1,
                                        name: "name",
                                        description: "description",
                                        thumbnail: MarvelThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp",
                                                                   extension: "png",
                                                                   image: UIImage()))
    
    override func setUp() {
    }
    override func tearDown() {
    }
    
    func testCharacterCellTitle() {
        self.cell.setup(character: &self.testCharacter)
        XCTAssertNotNil(self.cell.labelTitle.text)
    }
    
    func testCharacterCellLabel() {
        self.cell.setup(character: &self.testCharacter)
        XCTAssertEqual(self.cell.labelTitle.text!, self.testCharacter.name)
    }
    
    func testPrepareForSegueCell() {
        self.cell.prepareForReuse()
        XCTAssertNil(self.cell.imageIcon.image)
        XCTAssertNil(self.cell.labelTitle.text)
    }
    
}
