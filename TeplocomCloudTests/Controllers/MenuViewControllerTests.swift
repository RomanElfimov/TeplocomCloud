//
//  MenuViewControllerTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 07.10.2022.
//

import XCTest
@testable import TeplocomCloud

class MenuViewControllerTests: XCTestCase {

    // MARK: - System Under Test

    var sut: MenuViewController!
    var tableView: UITableView!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let vc = MenuViewController()
        sut = vc

        sut.loadViewIfNeeded()

        tableView = sut.tableView
    }

    override func tearDown() {
        sut = nil
        tableView = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    // Table View != nil
    func testWhenViewIsLoadedTableViewIsNotNil() {
        XCTAssertNotNil(tableView)
    }

    // Delegate / DataSource != nil
    func testWhenViewIsLoadedDelegateIsNotNil() {
        XCTAssertNotNil(tableView.delegate)
    }

    func testWhenViewIsLoadedDatasourceIsNotNil() {
        XCTAssertNotNil(tableView.dataSource)
    }

    // Sut is subscribe on Delegate / DataSource
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(tableView.delegate === sut)
    }

    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(tableView.dataSource === sut)
    }

    // Check number of sections
    func testNumberOfSectionsIsOne() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }

    // Check type of returning cell
    func testCellForRowAtIndexPathReturnsCell() {
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is MenuTableViewCell)
    }

    // Переиспользуется ли ячейка tableView
    func testCellForRowAtIndexPathDequeuesCellFromTableView() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        mockTableView.reloadData()

        // Отрабатываем метод dequeueReusableCell
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))

        XCTAssertTrue(mockTableView.cellIsDequeued)
    }

    // Отрабатывает ли метод заполнения ячейки контентом
    func testCellForRowCallsConfigure() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)

        let menuModel = MenuModel(rawValue: 0)?.description
        mockTableView.reloadData()

        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockContentCell

        XCTAssertEqual(cell.myLabel.text, menuModel)
    }

}

// MARK: - MenuViewControllerTests Extension

extension MenuViewControllerTests {

    // MARK: - Mock Table View

    class MockTableView: UITableView {
        var cellIsDequeued = false // флаг - была ли периспользована ячейка

        // Автоматизируем создание MockTableView
        static func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
            mockTableView.dataSource = dataSource

            // Регистрируем Mock ячейку
            mockTableView.register(MockContentCell.self, forCellReuseIdentifier: "Cell")
            return mockTableView
        }

        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true // Ставим флаг в true, чтобы потом проверить в тесте
            return super.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        }
    }

    // MARK: - Mock Table View Cell

    class MockContentCell: MenuTableViewCell {}
}
