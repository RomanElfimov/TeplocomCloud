//
//  MenuTableViewCellTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 07.10.2022.
//

import XCTest
@testable import TeplocomCloud

class MenuTableViewCellTests: XCTestCase {

    // MARK: - System Under Test

    var cell: MenuTableViewCell!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let controller = MenuViewController()
        controller.loadViewIfNeeded()

        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource

        cell = tableView?.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath(row: 0, section: 0)) as? MenuTableViewCell
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Public Methods

    // Проверяем есть ли у ячейки iconImageView
    func testCellHasIconImageView() {
        XCTAssertNotNil(cell.iconImageView)
    }

    // Находится ли iconImageView внутри View
    func testCellHasIconImageViewInContentView() {
        XCTAssertTrue(cell.iconImageView.isDescendant(of: cell.contentView))
    }

    // Проверяем есть ли у ячейки myLabel
    func testCellHasMyLabel() {
        XCTAssertNotNil(cell.myLabel)
    }

    // Находится ли iconImageView внутри View
    func testCellHasMyLabelInContentView() {
        XCTAssertTrue(cell.myLabel.isDescendant(of: cell.contentView))
    }
}

// MARK: - Fake Data Source

extension MenuTableViewCellTests {

    class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
