//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var viewModelDelegate: SettingsToViewModelProtocol?
    var localDataForCells: LocalDataForCellsInSettingsModel = LocalDataForCellsInSettingsModel(url: "", uploadIsOn: false, darkThemeIsOn: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // view asks for data if ready or will be updated
        viewModelDelegate?.getDataFromViewModelToSettings()
    }

    private func setupViews() {
        view.backgroundColor = .white
        setupNavigationBar()
        prepareCells()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Settings"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func prepareCells() {
        tableView.register(UrlForRequestCell.self, forCellReuseIdentifier: UrlForRequestCell.id)
        tableView.register(UploadSpeedCell.self, forCellReuseIdentifier: UploadSpeedCell.id)
        tableView.register(DarkThemeCell.self, forCellReuseIdentifier: DarkThemeCell.id)
    }
    
    func updateViews(appSettings: AppSettings) {
        self.localDataForCells = LocalDataForCellsInSettingsModel(url: appSettings.url ?? "updateViews() error", uploadIsOn: appSettings.measureUpload, darkThemeIsOn: appSettings.darkTheme)
        tableView.reloadData()
    }
    
}

// MARK: - TableView Configuration

extension SettingsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return UrlForRequestCell.nameForSection
        case 1: return UploadSpeedCell.nameForSection
        case 2: return DarkThemeCell.nameForSection
        default: return "none"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UrlForRequestCell.id, for: indexPath) as? UrlForRequestCell
            else { return UITableViewCell()}
            cell.delegate = self
            cell.configure(with: self.localDataForCells.url)
            return cell
        case 1: 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UploadSpeedCell.id, for: indexPath) as? UploadSpeedCell
            else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: localDataForCells.uploadIsOn)
            return cell
        case 2: guard let cell = tableView.dequeueReusableCell(withIdentifier: DarkThemeCell.id, for: indexPath) as? DarkThemeCell
            else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: localDataForCells.darkThemeIsOn)
            return cell
        default:
            return {
                let cell = UITableViewCell()
                cell.textLabel?.text = "something went wrong"
                return cell
            }()
        }
    }
    
}

// MARK: - Feedback from cells

extension SettingsViewController: URLCellProtocol, UploadSpeedCellProtocol, DarkThemeCellProtocol {
    func userEndEditing(url: String) {
        localDataForCells.url = url
        viewModelDelegate?.sendDataFromSettingsToViewModel(localSettings: self.localDataForCells)
    }
    
    func userСhangedMeasurements(uploadSpeed: Bool) {
        localDataForCells.uploadIsOn = uploadSpeed
        viewModelDelegate?.sendDataFromSettingsToViewModel(localSettings: self.localDataForCells)
    }
    
    func darkThemeChanged(darkIsOn: Bool) {
        localDataForCells.darkThemeIsOn = darkIsOn
        viewModelDelegate?.sendDataFromSettingsToViewModel(localSettings: self.localDataForCells)
    }
}

