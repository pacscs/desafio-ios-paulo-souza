//
//  MainTests.swift
//  desafio-ios-paulo-souzaTests
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import XCTest
@testable import desafio_ios_paulo_souza

class desafio_ios_paulo_souzaTests: XCTestCase {
    let controller: MainViewController = MainViewController()
    let testCharacter = MarvelCharacterData(offset: 0, limit: 20, total: 40, count: 0, results: [MarvelCharactersResult(id: 1, name: "name", description: "description", thumbnail: MarvelThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp",extension: "png", image: UIImage()))])
    
    override func setUpWithError() throws {
        self.controller.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        self.controller.characters.removeAll()
        self.controller.currentIndex = 0
        self.controller.numberOfItens = 0
    }
    
    func testSetUpView() {
        self.controller.setupView()
        XCTAssertTrue(self.controller.tableView.isHidden)
    }
    
    func testCharacterResults() {
        self.controller.handleResults(characters: self.testCharacter)
        XCTAssertEqual(self.controller.limit, 20)
        XCTAssertEqual(self.controller.currentIndex, 20)
        XCTAssertEqual(self.controller.numberOfItens, 40)
        XCTAssertEqual(self.controller.characters.count, 1)
    }
    
    func testLoadCharacters() {
        self.controller.loadCharacters(fake: true)
        XCTAssertEqual(self.controller.characters.count, 20)
    }
    
    func testHandleCharacters() {
        DispatchQueue.main.async {
            self.controller.handleResults(characters: self.testCharacter)
            XCTAssertEqual(self.controller.characters.count, 1)
            XCTAssertTrue(self.controller.tableView.isHidden == true)
        }
    }
    
    func testHandleCharactersResults() {
        let asyncExpectation = expectation(description: "Async block executed")
        self.controller.handleResults(characters: self.testCharacter)
        DispatchQueue.main.async {
            XCTAssertEqual(self.controller.characters.count, 1)
            XCTAssertTrue(self.controller.tableView.isHidden == false)
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCharacterTableView() {
        self.controller.handleResults(characters: self.testCharacter)
        self.controller.tableView.reloadData()
        XCTAssertNotNil(self.controller.tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
    }
    
    func testCharacterTableViewCell() {
        self.controller.handleResults(characters: self.testCharacter)
        self.controller.tableView.reloadData()
        XCTAssertTrue(self.controller.tableView.cellForRow(at: IndexPath(row: 0, section: 0))!.classForCoder == ListTableViewCell.classForCoder())
    }
    
    func testCharacteCell() {
        self.controller.handleResults(characters: self.testCharacter)
        self.controller.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.controller.tableView.cellForRow(at: indexPath)!
        self.controller.tableView(self.controller.tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func testDidSelectedCharacter() {
        self.controller.handleResults(characters: self.testCharacter)
        self.controller.tableView.reloadData()
        self.controller.tableView(self.controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    func testSelectCharacter() {
        self.controller.handleResults(characters: self.testCharacter)
        self.controller.currentIndex = 1
        self.controller.numberOfItens = 2
        self.controller.loading = false
        self.controller.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.controller.tableView.cellForRow(at: indexPath)!
        self.controller.tableView(self.controller.tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
}
