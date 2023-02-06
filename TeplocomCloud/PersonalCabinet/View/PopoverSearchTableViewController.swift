//
//  PopoverCountriesTableViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 10.08.2021.
//

import UIKit

final class PopoverSearchTableViewController: UITableViewController {

    // MARK: - Public Properties

    public var dataSourceArray: [String] = ["Поиск..."]
    public var makeRequestAction: (() -> Void)?
    public var completion: ((String) -> Void)?

    // MARK: - Lifecycle

    override func viewWillLayoutSubviews() {
        if dataSourceArray.count == 0 {
            preferredContentSize = CGSize(width: 0, height: 0)
        } else {
            preferredContentSize = CGSize(width: 200, height: tableView.contentSize.height)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = dataSourceArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let text = cell?.textLabel?.text else { return }
        completion!(text)
        self.dismiss(animated: true, completion: nil)
    }
}
