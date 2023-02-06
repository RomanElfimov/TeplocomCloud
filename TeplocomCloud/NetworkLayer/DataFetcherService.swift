//
//  DataFetcherService.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.08.2021.
//

import Foundation
import KeychainSwift

// MARK: DataFetcherService
final class DataFetcherService {

    let dataFethcer = NetworkDataFetcher()
    let authScheme = "https://api-auth.bast.ru/api/v1/"
    let cloudSheme = "https://cloud-new.bast-dev.ru/api/v1/"
    
    private let keychain = KeychainSwift(keyPrefix: "Teplocom")
    private lazy var deviceUID: String = {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "DeviceUID") ?? ""
    }()

    // MARK: - Token Logic

    /// Проверка валидности токена
    private func checkAndRefreshToken(completion: @escaping(_ token: String) -> Void) {
        guard let refreshToken = keychain.get("refreshToken") else { return }

        getRequestWithToken { [weak self] personInfo in
            if let error = personInfo?.error {
                if error == "Срок действия токен исток или не верный формат токена." {

                    self?.refreshToken(refreshToken: refreshToken) { [weak self] result in
                        guard let result = result else { return }
                        if let error = result.error { print("\(#function) Error in Refresh Token: \(error)") }

                        guard let jwtToken = result.jwt else { return }
                        guard let refreshToken = result.refreshToken else { return }

                        // saving tokens in keychain
                        self?.keychain.set(jwtToken, forKey: "token")
                        self?.keychain.set(refreshToken, forKey: "refreshToken")

                        let token = self?.keychain.get("token") ?? ""
                        completion(token)
                    }
                }

            } else {
                let token = self?.keychain.get("token") ?? ""
                completion(token)
            }
        }
    }

    private func getRequestWithToken(completion: @escaping(PersonalInfoBackendModel?) -> Void) {
        let url = "\(authScheme)personal-data"
        let token = keychain.get("token") ?? ""
        dataFethcer.fetchGenericJSONData(with: url, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
    }

    // MARK: - AUTHENTICATION

    // 1. Получить SMS код:- /auth/request-code/no-captcha
    func getAuthCode(parameters: [String: String], completion: @escaping(AuthCodeBackendModel?) -> Void) {
        let urlString = "\(authScheme)auth/request-code/no-captcha"
        dataFethcer.fetchGenericJSONData(with: urlString, of: .post, header: nil, parameters: parameters, response: completion)
    }

    // 2. Подтвердить SMS код:- /auth/login
    func login(parameters: [String: String], completion: @escaping(LoginBackendModel?) -> Void) {
        let urlString = "\(authScheme)auth/login"
        dataFethcer.fetchGenericJSONData(with: urlString, of: .post, header: nil, parameters: parameters, response: completion)
    } // На этом авторизация пользователя завершена, можем далее работать с токеном

    /// Обновить токен авторизации
    func refreshToken(refreshToken: String, completion: @escaping(ServiceFeedbackModel?) -> Void) {
        let urlString = "\(authScheme)auth/refresh/\(refreshToken)"
        dataFethcer.fetchGenericJSONData(with: urlString, of: .get, header: nil, parameters: nil, response: completion)
    }

    // MARK: - PERSONAL CABINET

    // MARK: - PersonalData

    /// Получить информацию о пользователе
    func getPersonalData(completion: @escaping(PersonalInfoBackendModel?) -> Void) {
        let url = "\(authScheme)personal-data"
        checkAndRefreshToken { [weak self] token in

            self?.dataFethcer.fetchGenericJSONData(with: url, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, statusCodeCompletion: { _ in
            }, response: completion)

            self?.dataFethcer.fetchGenericJSONData(with: url, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Изменить информацию о пользователе
    func editPersonalData(parameters: [String: Any], completion: @escaping(PersonalInfoBackendModel?) -> Void) {
        let url = "\(authScheme)personal-data"
        checkAndRefreshToken { token in
            self.dataFethcer.fetchGenericJSONData(with: url, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, response: completion)
        }
    }

    // MARK: - Email

    /// Изменение email
    func changeEmail(parameters: [String: String], completion: @escaping(PersonalInfoBackendModel?) -> Void) {
        let url = "\(authScheme)email-change"
        checkAndRefreshToken { token in
            self.dataFethcer.fetchGenericJSONData(with: url, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, response: completion)
        }
    }

    // MARK: - Phone Number

    /// Первый запрос на изменение номера телефона
    func phoneNumberChangeRequestCode(parameters: [String: String], completion: @escaping(AuthCodeBackendModel?) -> Void) {
        let urlString = "\(authScheme)phone-number-change/request-code"
        checkAndRefreshToken { token in
            self.dataFethcer.fetchGenericJSONData(with: urlString, of: .postWithHeader, header: "Bearer \(token)", parameters: parameters, response: completion)
        }
    }

    /// Второй запрос на изменение номера телефона
    func two(parameters: [String: String], completion: @escaping(AuthCodeBackendModel?) -> Void) {
        let urlString = "\(authScheme)phone-number-change/verify-first-code"
        checkAndRefreshToken { token in
            self.dataFethcer.fetchGenericJSONData(with: urlString, of: .postWithHeader, header: "Bearer \(token)", parameters: parameters, response: completion)
        }
    }

    /// Третий запрос на изменение номера телефона
    func three(parameters: [String: String], completion: @escaping(AuthCodeBackendModel?) -> Void) {
        let urlString = "\(authScheme)phone-number-change/verify-second-code"
        checkAndRefreshToken { token in
            self.dataFethcer.fetchGenericJSONData(with: urlString, of: .postWithHeader, header: "Bearer \(token)", parameters: parameters, response: completion)
        }
    }

    // MARK: - Search API

    /// Поиск по городам в личном кабинете
    func searchCities(searchText: String, completion: @escaping([String]?) -> Void) {
        let urlString = "\(authScheme)suggestions/city?query=\(searchText)&count=7".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        dataFethcer.fetchGenericJSONData(with: urlString!, of: .get, header: nil, parameters: nil, response: completion)
    }

    /// Поиск по странам в личном кабинете
    func searchCountries (searchText: String, completion: @escaping([String]?) -> Void) {
        let urlString = "\(authScheme)suggestions/country?query=\(searchText)&count=7".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        dataFethcer.fetchGenericJSONData(with: urlString!, of: .get, header: nil, parameters: nil, response: completion)
    }

    // MARK: - TEPLOCOM API

    // MARK: - Device

    /// Получение устройств связанных с пользователем
    public func getBindedDevices(completion: @escaping([BindedDevicesBackendModel]?) -> Void) {
        let urlString = "\(cloudSheme)devices/binded"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Получение оперативных данных с устройства
    public func getDeviceHotData(completion: @escaping(HotDataBackendModel?) -> Void) {
        // let urlString = "\(cloudSheme)devices/\(deviceUID)/hot-data"
        let urlString = "https://c02d4959-941d-4a43-ab86-09a6fce82495.mock.pstmn.io/hotData"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Включение/отключение котла
    public func switchBoilerState(statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping (HotDataBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/hot-data"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .putWithHeader, header: "Bearer \(token)", parameters: nil, statusCodeCompletion: statusCodeCompletion, response: completion)
        }
    }

    // Информация об устройстве

    /// Получение информации об устройстве (клиентское наименование, версия прошивки и т.д.)
    public func getDeviceInfo(completion: @escaping(DeviceInfoBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/info"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Изменение информации об устройстве
    public func editDeviceInfo(parameters: [String: String], statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(DeviceInfoBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/info"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, statusCodeCompletion: statusCodeCompletion, response: completion)
        }
    }

    /// Обновить прошивку на устройстве
    public func reflashFirmware(statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(DeviceInfoBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/firmware/reflash"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .postWithHeader, header: "Bearer \(token)", parameters: nil, statusCodeCompletion: statusCodeCompletion, response: completion)
        }
    }

    /// Получение настроек уведомления устройством
    public func getNotificationSettings(completion: @escaping(NotificationSettingsModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/settings/notify"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Изменение настроек уведомления устройством
    public func editNotificationSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(NotificationSettingsModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/settings/notify"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, statusCodeCompletion: statusCodeCompletion, response: completion)
        }
    }

    // MARK: - Sensors

    // Температурный датчик

    /// Получение списка температурных датчиков устройства пользователя
    public func getTemperatureSensorsList(completion: @escaping([TemperatureSensorsListBackendModel]?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/temperature-sensors"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Получение настроек температурного датчика устройства
    public func getTemperatureSensorSettings(sensorId: String, completion: @escaping(TemperatureSensorBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/temperature-sensors/\(sensorId)"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Изменение настроек температурного датчика устройства
    public func editTemperatureSensorSettings(sensorId: String, parameters: [String: Any], statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(TemperatureSensorBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/temperature-sensors/\(sensorId)"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, response: completion)
        }
    }

    /// Удаление настроек температурного датчика устройства
    public func deleteTemperatureSensorSettings(sensorId: String, completion: @escaping(TemperatureSensorBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/temperature-sensors/\(sensorId)"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .delete, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Получение экспертных настроек температурного датчика устройства
    public func getTemperatureSensorExpertSettings(sensorId: String, completion: @escaping(TemperatureSensorExpertSettingsBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/temperature-sensors/\(sensorId)/expert"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Изменение экспертных настроек температурного датчика устройства
    public func editTemperatureSensorExpertSettings(sensorId: String, parameters: [String: Any], statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(TemperatureSensorBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/temperature-sensors/\(sensorId)/expert"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, response: completion)
        }
    }

    // Нераспределенный температурный датчик

    /// Получение критерия наличия нераспределенного температурного датчика устройства
    public func fetchUnallocatedTempSensor(completion: @escaping(UnallocatedSenorModel?) -> Void) {
        //        let urlString = "\(cloudSheme)devices/\(deviceUID)/temperature-sensors/search"
        let urlString = "https://c02d4959-941d-4a43-ab86-09a6fce82495.mock.pstmn.io/unallocatedSensor"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Установка роли и настроек нераспределенного температурного датчика устройства
    public func setUnallocatedTempSensor(parameters: [String: Any], statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(TemperatureSensorBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/temperature-sensors/set-role-and-settings-of-undefined"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .postWithHeader, header: "Bearer \(token)", parameters: parameters, statusCodeCompletion: statusCodeCompletion, response: completion)
        }
    }

    // MARK: - Boiler

    /// Получение настроек алгоритма управления котлом устройства
    public func getBoilerSettings(completion: @escaping(BoilerBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/settings"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Изменение настроек алгоритма управления котлом устройства
    public func editBoilerSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(BoilerBackendModel?) -> Void) {

        let urlString = "https://e8291aaf-192d-409f-97a5-4a5c39fcbc69.mock.pstmn.io/users"
        // "\(cloudSheme)devices/\(deviceUID)/settings"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, statusCodeCompletion: statusCodeCompletion, response: completion)
        }
    }

    /// Получение настроек алгоритма управления котлом устройства
    public func getBoilerExpertSettings(completion: @escaping(BoilerExpertSettingsBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/settings"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Изменение настроек алгоритма управления котлом устройства
    public func editBoilerExpertSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(BoilerExpertSettingsBackendModel?) -> Void) {

        let urlString = "https://e8291aaf-192d-409f-97a5-4a5c39fcbc69.mock.pstmn.io/users"
        // "\(cloudSheme)devices/\(deviceUID)/settings"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, statusCodeCompletion: statusCodeCompletion, response: completion)
        }
    }

    /// Получение настроек котла устройства при алгоритме Open Therm
    public func getBoilerOpenThermSettings(completion: @escaping(BoilerOpenThermSettingsBackendModel?) -> Void) {
        let urlString = "\(cloudSheme)devices/\(deviceUID)/settings/open-therm"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .getWithHeader, header: "Bearer \(token)", parameters: nil, response: completion)
        }
    }

    /// Изменение настроек котла устройства при алгоритме Open Therm
    public func editBoilerOpenThermSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int?) -> Void, completion: @escaping(BoilerOpenThermSettingsBackendModel?) -> Void) {

        let urlString = "\(cloudSheme)devices/\(deviceUID)/settings/open-therm"
        checkAndRefreshToken { [weak self] token in
            self?.dataFethcer.fetchGenericJSONData(with: urlString, of: .putWithHeader, header: "Bearer \(token)", parameters: parameters, statusCodeCompletion: statusCodeCompletion, response: completion)
        }
    }
}
