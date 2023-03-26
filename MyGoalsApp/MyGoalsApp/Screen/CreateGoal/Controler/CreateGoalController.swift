//
//  CreateGoalController.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class CreateGoalController: UIViewController {
    
    fileprivate var goalsView: CreateGoalView {
        guard let view = self.view as? CreateGoalView else {return CreateGoalView()}
        return view
    }
    
    private lazy var goalValidation = GoalValidation()
    
    private var numberOfSections = 4
    
    private let heightForRow: CGFloat = 45
    
    private let heightForHeaderInSection: CGFloat = 50
    
    private var headerView: SelectedCategoryHeaderView!
    
    private let optionsCellArray: [ModelOptionsCell] = [
        ModelOptionsCell(typeCell: .quanti, nameCategory: TypeCell.quanti.nameCell),
        ModelOptionsCell(typeCell: .step, nameCategory: TypeCell.step.nameCell),
        ModelOptionsCell(typeCell: .check, nameCategory: TypeCell.check.nameCell)]
   
    public var onFinish: ((MyGoalApp)->())?
    
    private let arrayColorGoals: [TransformedColor] = [Colors.greenColor, Colors.redColor, Colors.orangeColor, Colors.blueColor, Colors.grayColor, Colors.darkGrayColor]
    
    override func loadView() {
        super.loadView()
        self.view = CreateGoalView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsView.tableView.delegate = self
        goalsView.tableView.dataSource = self
        configurationView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func closeButtunAction() {
        dismiss(animated: true)
    }

    private func configurationView() {
        goalsView.configure(with: ModelCreateGoalView(onAction: { [weak self] in
            self?.closeButtunAction()
        }))
    }
    
    private func updateSaveButtonCell() {
        goalsView.tableView.reloadRows(
            at: [IndexPath(row: .zero,
                           section: TypeDataSection.goalsSave.rawValue)],
            with: .none)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            goalsView.tableView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: keyboardHeight, right: .zero)
        }
    }
    
    @objc func keyboardWillHide() {
        goalsView.tableView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    private func saveNewMyGoals() {
        self.view.endEditing(true)
        
        if goalValidation.isValidate() {
            
            let myGoals = MyGoalApp(context: CoreDataManager.shared.viewContext)
            let color = TransformedColors(context: CoreDataManager.shared.viewContext)
            
            color.topColor = goalValidation.topColor
            color.bottomColor = goalValidation.bottomColor
            color.visualColor = goalValidation.visualColor
            color.buttonColor = goalValidation.buttonColor
            
            myGoals.id = UUID()
            myGoals.date = Date()
            myGoals.name = goalValidation.name
            myGoals.amount = goalValidation.quanti
            myGoals.step = goalValidation.step
            myGoals.totalCompleted = goalValidation.check
            myGoals.colors = color

            CoreDataManager.shared.saveMyGoals()
            self.onFinish?(myGoals)
        }
        self.dismiss(animated: true)
    }
    
    private func setWarningMessage(warning: Bool, myTextField: MyTextField) {
        guard let header = headerView else {
            return
        }
        let type = myTextField.typeCell
        
        myTextField.addBottomBorder(isHidden: warning)
        
        header.setWarningLabel(
            category: warning ? type?.rawValue : nil,
            isHidden: warning)
    }
}
extension CreateGoalController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let myTextFields = textField as? MyTextField else {
            return
        }
        
        guard let text = textField.text else {
            return
        }
        let number = Int16(text) ?? .zero
        
        let warningMessage = number > .zero ? false : true
        
        switch myTextFields.typeCell {
        case .name:
            goalValidation.name = text
            
        case .quanti:
            goalValidation.quanti = number
            setWarningMessage(warning: warningMessage, myTextField: myTextFields)
            
        case .step:
            goalValidation.step = number
            setWarningMessage(warning: warningMessage, myTextField: myTextFields)
            
        case .check:
            goalValidation.check = number
            
        default:
            break
        }
        updateSaveButtonCell()
    }
}
extension CreateGoalController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = TypeDataSection.init(rawValue: section)?.numberOfRowsInSection else {
            return 0
        }
        return number
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCellType = TypeDataSection(rawValue: indexPath.section)
        let postCell = TypeCell(rawValue: indexPath.row)
        
        switch postCellType {
        case .goalsName:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NameGoalCell.identifire, for: indexPath) as? NameGoalCell else {
                return UITableViewCell()
            }
            cell.configure(with: ModelNameGoalsCell())
            cell.mainTextField.delegate = self
            return cell
            
        case .goalsParametrs:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.identifire, for: indexPath) as? OptionsCell else {
                return UITableViewCell() }
            cell.mainTextField.delegate = self
            
            switch postCell {
            case .quanti:
                cell.configure(with: optionsCellArray[indexPath.row])
            case .step:
                cell.configure(with: optionsCellArray[indexPath.row])
            case .check:
                cell.configure(with: optionsCellArray[indexPath.row])
            default:
                break
            }
            return cell
            
        case .goalsColor:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableColorCell.identifire, for: indexPath) as? TableColorCell else {
                return UITableViewCell() }
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            return cell
            
        case .goalsSave:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SaveButtonCell.identifire, for: indexPath) as? SaveButtonCell else {
                return UITableViewCell() }
            cell.configure(with: ModelSaveButtonCell(validation: goalValidation.isValidate()))
            return cell
            
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        } else {
            return heightForHeaderInSection
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = TypeDataSection(rawValue: section)
        
        switch section {
        case .goalsParametrs:
            headerView = SelectedCategoryHeaderView(frame: CGRect(x: .zero, y: .zero, width: tableView.frame.width, height: .zero))
            
            return headerView
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postCell = TypeDataSection(rawValue: indexPath.section)
        
        switch postCell {
        case .goalsSave:
            if goalValidation.isValidate() {
                saveNewMyGoals()
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SaveButtonCell else {
            return
        }
        if goalValidation.isValidate() {
            cell.contentView.backgroundColor = cell.contentView.backgroundColor?.withAlphaComponent(0.5)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SaveButtonCell else {
            return
        }
        if goalValidation.isValidate() {
            cell.contentView.backgroundColor = Colors.activSaveButton
        }
    }
}
extension CreateGoalController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayColorGoals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifire, for: indexPath) as? ColorCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(color: arrayColorGoals[indexPath.row].visualColor)
        collectionView.selectItem(at: IndexPath(row: .zero, section: .zero) , animated: true, scrollPosition: .left)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goalValidation.setNewColor(color: arrayColorGoals[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = 18
        let countObjectInRow = 6
        let fullSpacing = spacing * (countObjectInRow + 1)
        let width = (Int(collectionView.frame.width) - fullSpacing) / countObjectInRow
        return CGSize(width: width, height: width)
    }
}
