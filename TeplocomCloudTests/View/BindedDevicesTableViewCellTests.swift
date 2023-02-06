//
//  BindedDevicesTableViewCellTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 07.10.2022.
//

import XCTest
@testable import TeplocomCloud

class BindedDevicesTableViewCellTests: XCTestCase {

    // MARK: - System Under Test

    var cell: BindedDevicesTableViewCell!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let controller = BindedDevicesViewController()

        controller.loadViewIfNeeded()

        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView.dataSource = dataSource

        cell = tableView.dequeueReusableCell(withIdentifier: BindedDevicesTableViewCell.cellIdentifier, for: IndexPath(row: 0, section: 0)) as? BindedDevicesTableViewCell
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Public Methods

    // Проверяем есть ли у ячейки nameLabel
    func testCellHasNameLabel() {
        XCTAssertNotNil(cell.nameLabel)
    }

    // Находится ли nameLabel внутри View
    func testCellHasNameLabelInContentView() {
        XCTAssertTrue(cell.nameLabel.isDescendant(of: cell.contentView))
    }

    // Проверяем есть ли у ячейки uidLabel
    func testCellHasUIDLabel() {
        XCTAssertNotNil(cell.uidLabel)
    }

    // Находится ли uidLabel внутри View
    func testCellHasUIDLabelInContentView() {
        XCTAssertTrue(cell.uidLabel.isDescendant(of: cell.contentView))
    }

    // Проверяем есть ли у ячейки statusLabel
    func testCellHasStatusLabel() {
        XCTAssertNotNil(cell.statusLabel)
    }

    // Находится ли statusLabel внутри View
    func testCellHasStatusLabelInContentView() {
        XCTAssertTrue(cell.statusLabel.isDescendant(of: cell.contentView))
    }
}

// MARK: - Fake Data Source

extension BindedDevicesTableViewCellTests {

    class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
