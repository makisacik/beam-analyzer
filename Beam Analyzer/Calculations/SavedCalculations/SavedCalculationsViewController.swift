//
//  SavedCalculationsViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.05.2023.
//
// swiftlint:disable line_length

import UIKit
import SnapKit

final class SavedCalculationsViewController: UIViewController {
    
    private let savedCalculationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SavedCalculationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    weak var coordinator: AppCoordinator?
    let viewModel = SavedCalculationsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCalculations()
    }
    
    private func setupViews() {
        title = "Saved Calculations"
        view.backgroundColor = .systemBackground
        savedCalculationsTableView.dataSource = self
        savedCalculationsTableView.delegate = self
        view.addSubview(savedCalculationsTableView)
    }
    
    private func makeConstraints() {
        savedCalculationsTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func reloadCalculations() {
        viewModel.fetchCalculations()
        DispatchQueue.main.async {
            self.savedCalculationsTableView.reloadData()
        }
    }
}

extension SavedCalculationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.calculations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SavedCalculationTableViewCell else { return UITableViewCell()}
        if let date = viewModel.calculations[indexPath.row].date {
            cell.textLabel?.text = "Calculation Saved in: " + DateUtil.getString(from: date)
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let savedCalculation = viewModel.calculations[indexPath.row]
        
        let type: CalculationType
        
        if savedCalculation.type == "freeEnd" {
            type = .freeEnd
        } else if savedCalculation.type == "fixed" {
            type = .fixed
        } else if savedCalculation.type == "roller" {
            type = .roller
        } else {
            type = .simply
        }
        
        let calculation = DeflectionCalculation(inputs: CalculationInputs(lenght: savedCalculation.lenght, width: savedCalculation.width, height: savedCalculation.height, pointLoad: savedCalculation.pointLoad, youngModulus: savedCalculation.youngModulus), result: savedCalculation.result, type: type)
        
        coordinator?.navigateToCalculationResult(deflectionCalculation: calculation, savedCalculation: savedCalculation)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteCalculation(viewModel.calculations[indexPath.row])
            viewModel.calculations.remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
}
