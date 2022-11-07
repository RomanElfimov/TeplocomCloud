//
//  HandleViewTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 08.10.2022.
//

import XCTest
@testable import TeplocomCloud

class HandleViewTests: XCTestCase {

    // MARK: - System Under Test

    var sut: HandleView!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = HandleView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    // Содержатся ли элементы интерфейса во view

    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut))
    }

    func testHasImageView() {
        XCTAssertNotNil(sut.imageView)
        XCTAssertTrue(sut.imageView.isDescendant(of: sut))
    }

    func testHasBottomView() {
        XCTAssertNotNil(sut.bottomView)
        XCTAssertTrue(sut.imageView.isDescendant(of: sut))
    }

    func testHasConfirmButton() {
        XCTAssertNotNil(sut.confirmButton)
        XCTAssertTrue(sut.confirmButton.isDescendant(of: sut))
    }

    // У кнопки есть действие
    func testConfirmButtonHasAction() {
        let confirmButton = sut.confirmButton

        guard let actions = confirmButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }

        XCTAssertTrue(actions.contains("confirmButtonTapped"))
    }
}
