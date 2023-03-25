//
//  ViewController.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

protocol GoalsDelegate {
    func updateGoals(model: MyGoalApp)
}

final class MainViewController: UIViewController {
    
    fileprivate var mainView: MainView {
        guard let view = self.view as? MainView else {
            return MainView() }
        return view
    }
    
    private let header = "My goals"
    
    private let headerForEditing = "Edit my goals"
    
    private var dataSource: EmptyDiffableDataSource<Section, AnyHashable>?
    
    private let myCompositionalLayout = MyCompositionalLayout()
    
    private var stateTrashButton: Bool {
        return dictionaryForRemove.count > 0
    }
    
    private var dictionaryForRemove: [IndexPath: Bool] = [:]
    
    private let mainEmtyView = EmptyMainView()
    
    private let completionEmtyView = EmptyCompletionView()
    
    private lazy var edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonAction))
    
    private lazy var trash = UIBarButtonItem(image: Images.trash, style: .plain, target: self, action: #selector(trashButtonAction))
    
    private var arrayMyGoals: [MyGoalApp] = [] {
        didSet {
            modelCell = mapMainCell(model: arrayMyGoals)
        }
    }
    
    private func searchCopletedGoals(currentGoals: inout [MyGoalApp]) -> [MyGoalApp] {
        
        var indexComletedGoals: [Int] = []
        
        for (index, value) in currentGoals.enumerated() {
            if value.finish {
                completionGoals.append(value)
                indexComletedGoals.append(index)
            }
        }
        indexComletedGoals
            .sorted(by: { $0 > $1})
            .forEach { index in
                currentGoals.remove(at: index)
            }
        return currentGoals
    }
    
    private var completionGoals: [MyGoalApp] = [] {
        didSet {
            modelCompletionCell = mapCompletionCell(model: completionGoals)
        }
    }
    
    private var modelCell: [ModelMyGoalsCell] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    private var modelCompletionCell: [ModelCompletionCell] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

    private func mapMainCell(model: [MyGoalApp]) -> [ModelMyGoalsCell] {
        model.map { goals in
            return ModelMyGoalsCell(id: goals.id,
                             name: goals.name,
                             date: goals.date,
                             cheak: Int(goals.totalCompleted),
                             counti: Int(goals.amount),
                             color: UIColor.decode(with: goals.colors.topColor),
                             onAction: {[weak self] button in
                self?.prepareDeleteCell(sender: button)
            })
        }
    }
    
    private func mapCompletionCell(model: [MyGoalApp]) -> [ModelCompletionCell] {
        model.map { goals in
            return ModelCompletionCell(
                id: goals.id,
                name: goals.name,
                cheak: Int(goals.totalCompleted),
                counti: Int(goals.amount) ,
                color: goals.colors,
                onAction: {[weak self] button in
                    guard let indexPath = self?.indexPathForDeleteButton(sender: button) else {
                        return
                    }
                    let item = self?.completionGoals[indexPath.row]
                    CoreDataManager.shared.deleteGoals(goals: item!)
                    self?.completionGoals.remove(at: indexPath.row)
                })
        }
    }
    
    private var selectNotes: SelectGoals = .goals {
        didSet {
            dictionaryForRemove.removeAll()
            self.isEditing = selectNotes == .goals ? false : true
            setIsHiddenTrashButton(state: stateTrashButton)
        }
    }
    
    private func setTitleForEditing() {
        self.title = self.isEditing ? headerForEditing : header
        edit.title = self.isEditing ? SelectGoals.editGoals.rawValue : SelectGoals.goals.rawValue
    }
    
     override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
         
         setTitleForEditing()
         
         let indexPaths = mainView.collectionView.indexPathsForVisibleItems
         
         indexPaths.forEach { indexPath in
             
             guard let section = Section(rawValue: indexPath.section) else {
                 return
             }
                          
             switch section {
             case .completion:
                 guard let cell = mainView.collectionView.cellForItem(at: indexPath) as? CompletionCell else {
                     return
                 }
                 cell.isEditing = editing
             case .main:
                 guard let cell = mainView.collectionView.cellForItem(at: indexPath) as? MyGoalsCell else {
                     return
                 }
                 cell.isEditing = editing
             }
         }
    }
    
    private func fetchMyGoals() {
        var allGoals = CoreDataManager.shared.receiveGoals()
        self.arrayMyGoals = searchCopletedGoals(currentGoals: &allGoals)
    }
    
    private func deleteGoals(index: Int) {
        CoreDataManager.shared.deleteGoals(goals: arrayMyGoals[index])
        arrayMyGoals.remove(at: index)
        setIsHiddenTrashButton(state: stateTrashButton)
    }
    
    private func indexPathForDeleteButton(sender: UIButton) -> IndexPath? {
        if mainView.collectionView != nil {
            let point = mainView.collectionView.convert(sender.center, from: sender.superview!)
            
            guard let indexPath = mainView.collectionView.indexPathForItem(at: point) else {
                return nil
            }
            return indexPath
        }
        return nil
    }
    
    private func prepareDeleteCell(sender: UIButton) {
        guard let index = indexPathForDeleteButton(sender: sender) else {
            return
        }
        switch sender.isSelected {
        case true:
            dictionaryForRemove[index] = true
        case false:
            dictionaryForRemove.removeValue(forKey: index)
        }
        setIsHiddenTrashButton(state: stateTrashButton)
    }
    
    private func indexForGoals(id: UUID, in list: [MyGoalApp]) -> IndexPath {
        let row = Int (list.firstIndex(where: { $0.id == id }) ?? 0 )
        return IndexPath(row: row, section: 0)
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.completion, .main])
        snapshot.appendItems(modelCompletionCell, toSection: .completion)
        snapshot.appendItems(modelCell, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    override func loadView() {
        super.loadView()
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMyGoals()
        setupCollectionView()
        setupNavigationBar()
        configureView()
        configureDataSource()
    }

    private func setupCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func configureView() {
        mainView.configure(with: ModelMain2View(onAction: {
            self.prepareForTransition()
        }))
    }
    
    private func setupNavigationBar() {
        self.title = header
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setRightBarButtonItems([edit], animated: true)
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = Section(rawValue: sectionIndex)

            switch section {
            case .completion:
                return self.myCompositionalLayout.setCompletionGoalsFlowLayout()
            case .main:
                return self.myCompositionalLayout.setCurrentGoalsFlowLayout()
            case .none:
                return nil
            }
        }
        return layout
    }
    
    private func setIsHiddenTrashButton(state: Bool) {
        self.navigationItem.leftBarButtonItem = state ? trash : nil
    }
    
    private func prepareForTransition() {
 //
        //
        //
    }
    
    @objc func editButtonAction() {
        selectNotes = selectNotes == .goals ? .editGoals : .goals
    }
    
    @objc func trashButtonAction() {
        if !dictionaryForRemove.isEmpty {
            dictionaryForRemove.keys
                .sorted{$0 > $1}
                .forEach { key in
                dictionaryForRemove.removeValue(forKey: key)
                deleteGoals(index: key.row)
            }
            mainView.collectionView.reloadData()
        }
    }
    
    func configureDataSource() {
        dataSource = EmptyDiffableDataSource<Section, AnyHashable>(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
           
            let section = Section(rawValue: indexPath.section)
         
            switch section {
                
            case .main:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyGoalsCell.identifire, for: indexPath) as? MyGoalsCell else {
                    return UICollectionViewCell()
                }
                guard let model = itemIdentifier as? ModelMyGoalsCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: model)
                cell.isEditing = self.isEditing
                return cell
                
            case .completion:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompletionCell.identifire, for: indexPath) as? CompletionCell else {
                    return UICollectionViewCell()
                }
                guard let model = itemIdentifier as? ModelCompletionCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: model)
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }, mainEmptyView: mainEmtyView, completionEmptyView: completionEmtyView)
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            guard let section = Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
         
            switch section {
                
            case .completion:
                
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderView.identifire,
                    for: indexPath) as? HeaderView
                view?.type = .completion
                view?.configure(with: ModelHeader(header: section.setTitle()))
                return view
                
            case .main:
                
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderView.identifire,
                    for: indexPath) as? HeaderView
                view?.type = .main
                view?.configure(with: ModelHeader(header: section.setTitle()))
                return view
            }
        }
    }
}
extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = Section(rawValue: indexPath.section)
        
        switch section {
            
        case .main:
            print("main")

            
        case .completion:
            print("completion")

        case .none:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         cell.contentView.layoutIfNeeded()
 
        if self.isEditing {
            cell.isSelected = dictionaryForRemove[indexPath] == true ? true : false
        }
    }
}

extension MainViewController: GoalsDelegate {
    
    func updateGoals(model: MyGoalApp) {
        let index = indexForGoals(id: model.id, in: arrayMyGoals)
        
        if model.finish {
            completionGoals.insert(model, at: 0)
            arrayMyGoals.remove(at: index.row)
        } else {
            arrayMyGoals[index.row] = model
        }
    }
}

