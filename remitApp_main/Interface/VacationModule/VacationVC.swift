//
//  VacationVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 05.06.2025.
//

import UIKit
import SnapKit

class VacationVC: UIViewController {
    
    private let vacationView = VacationView()
    
    override func loadView() {
        view = vacationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vacationView.delegate = self
        vacationView.vacationTable.delegate = self
        vacationView.vacationTable.dataSource = self
        vacationView.vacationTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        vacationView.quantDay.delegate = self
        navigationController?.navigationBar.tintColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        let bottomlineDate = CALayer()
        bottomlineDate.frame = CGRect(x: 0, y: vacationView.labelDateValue.frame.size.height, width: vacationView.labelDateValue.frame.size.width, height: 1)
        bottomlineDate.backgroundColor = UIColor.black.cgColor
        vacationView.labelDateValue.layer.addSublayer(bottomlineDate)
        
        let bottomlineQuant = CALayer()
        bottomlineQuant.frame = CGRect(x: 0, y: vacationView.quantDay.frame.size.height, width: vacationView.quantDay.frame.size.width, height: 1)
        bottomlineQuant.backgroundColor = UIColor.black.cgColor
        vacationView.quantDay.layer.addSublayer(bottomlineQuant)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        
        vacationView.backgroundStatement.snp.updateConstraints {
            $0.bottom.equalTo(vacationView.snp.bottom).offset(-keyboardHeight)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        
        vacationView.backgroundStatement.snp.updateConstraints {
            $0.bottom.equalTo(vacationView.snp.bottom)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension VacationVC: VacationViewDelegate {
    
    func didSelectButtonDoneKeyboard() {
        vacationView.quantDay.resignFirstResponder()
        print(1)
    }
    
    func didSelectDate() {
        let vc = CustomDatePickerVC()
        vc.completion = { [weak self] date in
            guard let strongSelf = self else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let dateString = formatter.string(from: date)
            strongSelf.vacationView.labelDateValue.text = dateString
        }
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
    
    func didSelectButtonVacation() {
        print(1)
    }
    
    
}

extension VacationVC: UITableViewDelegate {
    
}

extension VacationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

extension VacationVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: "")
            textField.text = newText
            return false
        }

        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if let number = Int(newText), number >= 1 && number <= 30 {
            return true
        }
        
        return false
    }
}
