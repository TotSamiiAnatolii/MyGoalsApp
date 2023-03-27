//
//  RealizationGoalController.swift
//  MyGoalsApp
//
//  Created by APPLE on 27.03.2023.
//

import UIKit

final class RealizationGoalController: UIViewController {

    public var onFinish: ((MyGoalApp) -> Void)?
    
    private var currentTotalComleted = 0
    
    fileprivate var mainView: RealizationGoalView {
        guard let view = self.view as? RealizationGoalView else {
            return RealizationGoalView(color: model.colors, frame: UIScreen.main.bounds) }
        return view
    }
    
    public var delegate: GoalsDelegate?
    
    private var model: MyGoalApp
    
    init(model: MyGoalApp) {
        self.model = model
        self.currentTotalComleted = Int(model.totalCompleted)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = RealizationGoalView(color: model.colors, frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        finishEditingGoals()
    }

    private func calculationFilling(counti: CGFloat, cheak: CGFloat) -> CGFloat {
        let fullHeight = self.view.frame.height
        let step = fullHeight / counti
        return step * cheak
    }
    
    private func configureView() {
        mainView.configure(with: RealizationGoalViewModel(
            name: model.name,
            currentState: String(model.totalCompleted),
            counti: String(model.amount),
            topColor: UIColor.decode(with: model.colors.topColor).cgColor,
            bottomColor: UIColor.decode(with: model.colors.bottomColor).cgColor,
            buttonColor: UIColor.decode(with: model.colors.buttonColor),
            height: calculationFilling(counti: CGFloat(model.amount), cheak: CGFloat(model.totalCompleted)),
            finish: model.finish,
            onAction: { button in
                switch button {
                case .addButton:
                    self.actionButtonAdd()
                case .finished:
                    self.finishButton()
                }
            }))
    }

    private func actionButtonAdd() {
        model.totalCompleted += Int16(model.step)
        configureView()
    }
    
    private func finishButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func finishEditingGoals() {
        if model.totalCompleted > currentTotalComleted {
            CoreDataManager.shared.saveMyGoals()
            delegate?.updateGoals(model: model)
        }
    }
}
