//
//  OffViewTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 08.10.2022.
//

import XCTest
@testable import TeplocomCloud

class OffViewTests: XCTestCase {

    // MARK: - System Under Test

    var sut: OffView!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = OffView()
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
        XCTAssertTrue(sut.bottomView.isDescendant(of: sut))
    }

    func testHasConfirmButton() {
        XCTAssertNotNil(sut.confirmButton)
        XCTAssertNotNil(sut.confirmButton.isDescendant(of: sut))
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
