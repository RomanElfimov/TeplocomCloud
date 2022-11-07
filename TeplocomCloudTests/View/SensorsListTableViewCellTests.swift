//
//  SensorsListTableViewCellTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 07.10.2022.
//

import XCTest
@testable import TeplocomCloud

class SensorsListTableViewCellTests: XCTestCase {

    // MARK: - System Under Test

    var cell: SensorsListTableViewCell!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let controller = SensorsListViewController()

        controller.loadViewIfNeeded()

        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView.dataSource = dataSource

        cell = tableView.dequeueReusableCell(withIdentifier: SensorsListTableViewCell.cellIdentifier, for: IndexPath(row: 0, section: 0)) as? SensorsListTableViewCell
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Public Methods

    // Проверяем есть ли у ячейки sensorImage
    func testCellHasSensorImage() {
        XCTAssertNotNil(cell.sensorImage)
    }

    // Находится ли sensorImage внутри View
    func testCellHasSensorImageInContentView() {
        XCTAssertTrue(cell.sensorImage.isDescendant(of: cell.contentView))
    }

    // // Проверяем есть ли у ячейки sensorNameLabel
    func testCellHasSensorNameLabel() {
        XCTAssertNotNil(cell.sensorNameLabel)
    }

    // Находится ли sensorNameLabel внутри View
    func testCellHasSensorNameLabelInContentView() {
        XCTAssertTrue(cell.sensorNameLabel.isDescendant(of: cell.contentView))
    }
}

// MARK: - Fake Data Source

extension SensorsListTableViewCellTests {

    class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
