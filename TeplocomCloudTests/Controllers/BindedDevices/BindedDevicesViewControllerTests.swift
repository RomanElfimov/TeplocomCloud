//
//  BindedDevicesViewControllerTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 07.10.2022.
//

import XCTest
@testable import TeplocomCloud

class BindedDevicesViewControllerTests: XCTestCase {

    // MARK: - System Under Test

    var sut: BindedDevicesViewController!
    var interactor: BindedDevicesBusinessLogicSpy!
    var tableView: UITableView!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let bindedDevicesController = BindedDevicesViewController()
        let bindedDevicesInteractor = BindedDevicesBusinessLogicSpy()

        bindedDevicesController.interactor = bindedDevicesInteractor
        sut = bindedDevicesController
        interactor = bindedDevicesInteractor

        sut.loadViewIfNeeded()

        tableView = sut.tableView
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        tableView = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    func testDisplayData() {
        XCTAssertTrue(interactor.iscCalledInteractor)
    }

    // Table View != nil
    func testWhenViewIsLoadedTableViewIsNotNil() {
        XCTAssertNotNil(tableView)
    }

    // Delegate / DataSource != nil
    func testWhenViewIsLoadedDelegateIsNotNil() {
        XCTAssertNotNil(tableView.delegate)
    }

    func testWhenViewIsLoadedDataSourceIsNotNil() {
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
        let model = BindedDevicesViewModel(name: "Foo", status: true, uid: "Bar")
        sut.bindedDevicesArray.append(model)

        tableView.reloadData()

        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is BindedDevicesTableViewCell)
    }

    // Переиспользуется ли ячейка tableView
    func testCellForRowAtIndexPathDequeuesCellFromTableView() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)

        let model = BindedDevicesViewModel(name: "Foo", status: true, uid: "Bar")
        sut.bindedDevicesArray.append(model)

        mockTableView.reloadData()

        // Отрабатываем метод dequeueReusableCell
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))

        XCTAssertTrue(mockTableView.cellIsDequeued)
    }

    // Отрабатывает ли метод заполнения ячейки контентом
    func testCellForRowCallsConfigure() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)

        let model = BindedDevicesViewModel(name: "Foo", status: true, uid: "Bar")
        sut.bindedDevicesArray.append(model)

        mockTableView.reloadData()

        let row = mockTableView.numberOfRows(inSection: 0) - 1 // элементы добавляются в конец
        let cell = mockTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! MockContentCell

        XCTAssertEqual(cell.model, model)
    }

    func testWhenDisplayDataTableViewReloaded() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView

        sut.displayData(event: .displayBindedDevices(data: []))

        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
    }
}

extension BindedDevicesViewControllerTests {

    // MARK: - Mock Table View

    class MockTableView: UITableView {
        var cellIsDequeued = false // флаг - была ли периспользована ячейка
        var isReloaded = false // флаг - перезагружается ли таблица

        override func reloadData() {
            super.reloadData()
            isReloaded = true // Ставим флаг в true, чтобы потом проверить в тесте
        }

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

    class MockContentCell: BindedDevicesTableViewCell {
        var model: BindedDevicesViewModel? // Проверим в тесте, заполнится ли это свойство

        override func setup(with model: BindedDevicesViewModel) {
            self.model = model
        }
    }
}
