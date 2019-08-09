//
//  SelectorViewController.swift
//  RxPanModal_Example
//
//  Created by Meng Li on 2019/08/06.
//  Copyright © 2019 XLAG. All rights reserved.
//

import RxPanModal

struct SelectorPanModalItem: RxPanModalItem {

    static let controllerType: RxPanModalPresentable.Type = SelectorViewController.self

    let names: [String]
    let didNameSelected: (String) -> Void
}

class SelectorViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let item: SelectorPanModalItem
    
    required init(item: SelectorPanModalItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        createConstraints()
    }
    
    private func createConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension SelectorViewController: RxPanModalPresentable {
    
    static func create(item: RxPanModalItem) -> Self? {
        guard let item = item as? SelectorPanModalItem else {
            return nil
        }
        return self.init(item: item)
    }
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    
}

extension SelectorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = item.names[indexPath.row]
        return cell
    }

}

extension SelectorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        item.didNameSelected(item.names[indexPath.row])
        dismiss(animated: true)
    }
    
}
