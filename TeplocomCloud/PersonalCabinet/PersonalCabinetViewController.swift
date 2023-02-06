//
//  PersonalCabinetTableViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import UIKit

// MARK: - Display logic protocol

protocol PersonalCabinetDisplayLogic: AnyObject {
    func displayData(viewModel: PersonalCabinet.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class PersonalCabinetViewController: UIViewController {

    // MARK: - External vars

    private(set) var router: PersonalCabinetRoutingLogic?

    // MARK: - Private vars

    private var interactor: PersonalCabinetBusinessLogic?

    private var isEmailVerified: Bool = false

    private var countriesArray: [String] = []
    private var citiesArray: [String] = []

    private var currentTextField: UITextField?
    private var popVC: PopoverSearchTableViewController!

    // MARK: - Interface Properties

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .insetGrouped)
        return table
    }()

    // Logo
    private lazy var logoCell = PersonalCabinetUtilities().createCell()
    private lazy var logoImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "TeplocomMainLogo")
        return iv
    }()

    // First/Last Name
    private lazy var personNameCell = PersonalCabinetUtilities().createCell()
    private lazy var firstNameTextField = PersonalCabinetUtilities().createTextField(placeholder: "Имя")
    private lazy var secondNameTextField = PersonalCabinetUtilities().createTextField(placeholder: "Фамилия")

    // Email
    private lazy var emailCell = PersonalCabinetUtilities().createCell()
    private lazy var emailTextField = PersonalCabinetUtilities().createTextField(placeholder: "Email", text: "testexample@gmail.com")
    private lazy var isVerifiedLabel: UILabel = {
        let label = UILabel()
        label.text = "Не подтвержден"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    private lazy var emailActionButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "gear")!.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor")!)
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        return button
    }()

    // Phone Number
    private lazy var phoneCell = PersonalCabinetUtilities().createCell()
    private lazy var phoneTextField = PersonalCabinetUtilities().createTextField(placeholder: "Номер телефона", text: "+X-XXX-XXX-XX-XX")
    private lazy var phoneActionButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "gear")!.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor")!)
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        return button
    }()

    // Location
    private lazy var locationCell = PersonalCabinetUtilities().createCell()
    private lazy var countryTextField = PersonalCabinetUtilities().createTextField(placeholder: "Страна")
    private lazy var cityTextField = PersonalCabinetUtilities().createTextField(placeholder: "Город")

    // MARK: - Inits

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup VIP Cycle

    private func setup() {
        let viewController = self
        let interactor = PersonalCabinetInteractor()
        let presenter = PersonalCabinetPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        let router = PersonalCabinetRouter()
        viewController.router = router
        router.viewController = viewController
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setupNavigationBar()

        interactor?.makeRequest(request: .fetchUserPersonalData)
    }

    override func viewWillAppear(_ animated: Bool) {

        // Notification center observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private Methods

    private func configureUI() {
        // General
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray6

        tableView.delegate = self
        tableView.dataSource = self

        countryTextField.delegate = self
        cityTextField.delegate = self

        createRefreshControl()

        // Logo image
        logoCell.addSubview(logoImage)
        logoCell.backgroundColor = .systemGray6

        logoImage.centerX(inView: logoCell)
        logoImage.anchor(top: logoCell.topAnchor, left: logoCell.leftAnchor, bottom: logoCell.bottomAnchor, right: logoCell.rightAnchor, paddingTop: 24, paddingLeft: 8, paddingBottom: 12, paddingRight: 8)

        // Person Name cell
        let personNamePlaceholderView = PersonalCabinetUtilities().createView()

        let personNameStack = UIStackView(arrangedSubviews: [firstNameTextField, secondNameTextField])
        personNameStack.axis = .vertical
        personNameStack.spacing = 2
        personNameStack.distribution = .fillProportionally

        personNameCell.contentView.addSubview(personNamePlaceholderView)
        personNamePlaceholderView.anchor(top: personNameCell.topAnchor, left: personNameCell.leftAnchor, bottom: personNameCell.bottomAnchor, right: personNameCell.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)

        personNamePlaceholderView.addSubview(personNameStack)
        personNameStack.anchor(top: personNamePlaceholderView.topAnchor, left: personNamePlaceholderView.leftAnchor, bottom: personNamePlaceholderView.bottomAnchor, right: personNamePlaceholderView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)

        // Email
        let emailPlaceholderView = PersonalCabinetUtilities().createView()

        let emailInfoStack = UIStackView(arrangedSubviews: [emailTextField, isVerifiedLabel])
        emailInfoStack.axis = .vertical
        emailInfoStack.spacing = 8
        emailInfoStack.distribution = .fillEqually

        emailCell.contentView.addSubview(emailPlaceholderView)
        emailPlaceholderView.anchor(top: emailCell.topAnchor, left: emailCell.leftAnchor, bottom: emailCell.bottomAnchor, right: emailCell.rightAnchor, paddingTop: 16, paddingLeft: 8, paddingBottom: 16, paddingRight: 8)

        emailPlaceholderView.addSubview(emailInfoStack)
        emailPlaceholderView.addSubview(emailActionButton)

        emailInfoStack.anchor(top: emailPlaceholderView.topAnchor, left: emailPlaceholderView.leftAnchor, bottom: emailPlaceholderView.bottomAnchor, right: emailActionButton.leftAnchor, paddingTop: 22, paddingLeft: 8, paddingBottom: 22)
        emailActionButton.centerY(inView: emailPlaceholderView)
        emailActionButton.setDimensions(width: 30, height: 30)
        emailActionButton.anchor(left: emailInfoStack.rightAnchor, right: emailPlaceholderView.rightAnchor, paddingRight: 12)

        // Phone
        let phonePlaceholderView = PersonalCabinetUtilities().createView()

        phoneCell.contentView.addSubview(phonePlaceholderView)
        phonePlaceholderView.anchor(top: phoneCell.topAnchor, left: phoneCell.leftAnchor, bottom: phoneCell.bottomAnchor, right: phoneCell.rightAnchor, paddingTop: 16, paddingLeft: 8, paddingBottom: 16, paddingRight: 8)

        phonePlaceholderView.addSubview(phoneTextField)
        phonePlaceholderView.addSubview(phoneActionButton)

        phoneTextField.anchor(top: phonePlaceholderView.topAnchor, left: phonePlaceholderView.leftAnchor, bottom: phonePlaceholderView.bottomAnchor, right: phoneActionButton.leftAnchor, paddingTop: 22, paddingLeft: 8, paddingBottom: 22)
        phoneActionButton.centerY(inView: phonePlaceholderView)
        phoneActionButton.setDimensions(width: 30, height: 30)
        phoneActionButton.anchor(left: phoneTextField.rightAnchor, right: phonePlaceholderView.rightAnchor, paddingRight: 12)

        // Location
        let locationPlaceholderView = PersonalCabinetUtilities().createView()

        let locationStack = UIStackView(arrangedSubviews: [countryTextField, cityTextField])
        locationStack.axis = .vertical
        locationStack.spacing = 2
        locationStack.distribution = .fillProportionally

        locationCell.contentView.addSubview(locationPlaceholderView)
        locationPlaceholderView.anchor(top: locationCell.topAnchor, left: locationCell.leftAnchor, bottom: locationCell.bottomAnchor, right: locationCell.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)

        locationPlaceholderView.addSubview(locationStack)
        locationStack.anchor(top: locationPlaceholderView.topAnchor, left: locationPlaceholderView.leftAnchor, bottom: locationPlaceholderView.bottomAnchor, right: locationPlaceholderView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
    }

    private func setupNavigationBar() {
        title = "Профиль"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // background color
        appearance.backgroundColor = UIColor(named: "TeplocomColor")
        // title customization
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.
        navigationItem.standardAppearance = appearance
        navigationItem.backButtonTitle = ""

        // Right Menu button
        let editImage = UIImage(systemName: "square.and.pencil")!.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let editButton = UIBarButtonItem(image: editImage, style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton

        // Back Button Arrow
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    }

    private func createRefreshControl() {
        let myRefreshControl = UIRefreshControl()
        myRefreshControl.attributedTitle = NSAttributedString(string: "Обновляем данные...")
        myRefreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        myRefreshControl.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        self.tableView.alwaysBounceVertical = true
        self.tableView.refreshControl = myRefreshControl
    }

    // MARK: - Selectors

    @objc private func emailButtonTapped() {
        router?.navigateToDetail(navigationType: .navigateToEmailManagement(email: emailTextField.text ?? "", isVerified: isEmailVerified))
    }

    @objc private func phoneButtonTapped() {
        router?.navigateToDetail(navigationType: .navigateToPhoneNumberChange)
    }

    @objc private func refresh(sender: UIRefreshControl) {
        interactor?.makeRequest(request: .fetchUserPersonalData)
        tableView.reloadData()
        sender.endRefreshing()
    }

    // keybord show action
    @objc func keyboardWillShow(notification: Notification) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: notification.getKeyBoardHeight, right: 0)
    }
    // keyboard hide action
    @objc func keyboardWillHide(notification: Notification) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension DisplayLogic

extension PersonalCabinetViewController: PersonalCabinetDisplayLogic {
    func displayData(viewModel: PersonalCabinet.Model.ViewModel.ViewModelData) {

        switch viewModel {

        case .displayPersonalData(viewModel: let viewModel):
            isEmailVerified = viewModel.isEmailConfirmed
            firstNameTextField.text = viewModel.firstName
            secondNameTextField.text = viewModel.lastName

            emailTextField.text = viewModel.email

            if viewModel.isEmailConfirmed {
                isVerifiedLabel.text = "Подтвержден"
            } else {
                isVerifiedLabel.text = "Не подтвержден"
            }

            phoneTextField.text = viewModel.phoneNumber

            countryTextField.text = viewModel.country
            cityTextField.text = viewModel.city

            setupTextFields(isEdit: false)

        case .displayCountries(let response):
            countriesArray = response

        case .displayCities(let response):
            citiesArray = response
        }
    }

}

// MARK: - Extension PopoverPresentation

extension PersonalCabinetViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - Extension UITextFieldDelegate

extension PersonalCabinetViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {

        popVC = PopoverSearchTableViewController()

        // показываем табличку с дейсвиями
        popVC.modalPresentationStyle = .popover

        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self

        // source view - куда указывает стрелочка
        popOverVC?.sourceView = textField
        popOverVC?.sourceRect = CGRect(x: textField.bounds.midX - 50, y: textField.bounds.midY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 200, height: 150)

        popVC.completion = { text in
            textField.text = text
        }

        self.present(popVC, animated: true, completion: nil)

        currentTextField = textField

        countryTextField.addTarget(self, action: #selector(countriesTextFieldAction), for: .editingChanged)
        cityTextField.addTarget(self, action: #selector(citiesTextFieldAction), for: .editingChanged)
    }

    @objc func countriesTextFieldAction() {

        popVC.dataSourceArray = countriesArray

        popVC.makeRequestAction = { [unowned self] in
            interactor?.makeRequest(request: .searchCountries(searchText: currentTextField?.text ?? ""))
            popVC.tableView.reloadData()
        }

        popVC.makeRequestAction?()
    }

    @objc func citiesTextFieldAction() {
        popVC.dataSourceArray = citiesArray
        popVC.makeRequestAction = { [unowned self] in
            interactor?.makeRequest(request: .searchCities(searchText: currentTextField?.text ?? ""))
            popVC.tableView.reloadData()
        }

        popVC.makeRequestAction?()
    }

}

// MARK: - TextFields Setup

extension PersonalCabinetViewController {

    @objc func cancelButtonTapped() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(editButtonTapped))

        setupTextFields(isEdit: false)
        interactor?.makeRequest(request: .fetchUserPersonalData)
    }

    @objc func editButtonTapped() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))

        setupTextFields(isEdit: true)
        firstNameTextField.becomeFirstResponder()
    }

    @objc func saveButtonTapped() {
        guard let firstName = firstNameTextField.text, firstName != "" else {
            showAlert(with: "Неверное имя", and: "Убедитесь в правильности заполения этого поля")
            return
        }

        guard let secondName = secondNameTextField.text, secondName != "" else {
            showAlert(with: "Неверная фамилия", and: "Убедитесь в правильности заполения этого поля")
            return
        }

        guard let country = countryTextField.text, country != "" else {
            showAlert(with: "", and: "Укажите страну")
            return
        }

        guard let city = cityTextField.text, city != "" else {
            showAlert(with: "", and: "Укажите город")
            return
        }

        let editPersonalDataParameters: [String: Any] = ["firstName": firstName,
                                                         "lastName": secondName,
                                                         "isProfessionalUser": true,
                                                         "country": country,
                                                         "city": city]
        interactor?.makeRequest(request: .editPersonalData(parameters: editPersonalDataParameters))

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(editButtonTapped))
    }

    private func setupTextFields(isEdit: Bool) {

        firstNameTextField.isUserInteractionEnabled = isEdit
        secondNameTextField.isUserInteractionEnabled = isEdit
        countryTextField.isUserInteractionEnabled = isEdit
        cityTextField.isUserInteractionEnabled = isEdit

        let accentColor = UIColor(named: "TeplocomColor")

        if isEdit {
            firstNameTextField.textColor = accentColor
            secondNameTextField.textColor = accentColor
            countryTextField.textColor = accentColor
            cityTextField.textColor = accentColor
        } else {
            firstNameTextField.textColor = .label
            secondNameTextField.textColor = .label
            countryTextField.textColor = .label
            cityTextField.textColor = .label
        }
    }

}

// MARK: - UITable View Delegate, DataSource

extension PersonalCabinetViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return logoCell
        case 1:
            return personNameCell
        case 2:
            return emailCell
        case 3:
            return phoneCell
        case 4:
            return locationCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
        case 0:
            return 160
        case 1:
            return 158
        case 2:
            return 122
        case 3:
            return 110
        case 4:
            return 141
        default:
            return 10
        }
    }
}

// MARK: - Notification Extension

extension Notification {

    var getKeyBoardHeight: CGFloat {

        let userInfo: NSDictionary = self.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        return keyboardRectangle.height
    }

}
