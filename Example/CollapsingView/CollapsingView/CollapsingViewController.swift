//
//  ContentView.swift
//  CollapsingView
//
//  Created by lee on 2021/05/26.
//

import UIKit

final class CollapsingViewController: UIViewController {

    private enum CollapsingConstant {
        static let collapsingViewHeight: CGFloat = 50
        static let collapsingDuration: TimeInterval = 0.2
    }

    private var lastContentOffset: CGFloat = 0.0

    private var collapsingViewHeightConstraint: NSLayoutConstraint!

    private let collapsingView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: UITableView = {
        let view = UITableView()
        view.bounces = false
        view.alwaysBounceVertical = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
    }

    private func configure() {
        view.backgroundColor = .white
        view.addSubview(collapsingView)
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func makeConstraint() {
        collapsingViewHeightConstraint = collapsingView.heightAnchor.constraint(equalToConstant: CollapsingConstant.collapsingViewHeight)

        NSLayoutConstraint.activate([
            collapsingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collapsingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collapsingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collapsingViewHeightConstraint,

            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: collapsingView.bottomAnchor)
        ])
    }

    private func updateCollapsingViewHeightConstraint(_ height: CGFloat) {
        UIView.animate(withDuration: CollapsingConstant.collapsingDuration) {
            self.collapsingViewHeightConstraint.constant = height
            self.view.layoutIfNeeded()
        }
    }
}

extension CollapsingViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard scrollView == self.tableView else { return }

        // Scrolled to bottom
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {

            self.updateCollapsingViewHeightConstraint(.zero)
        }

        // Scrolling up, scrolled to top
        if (scrollView.contentOffset.y < self.lastContentOffset || scrollView.contentOffset.y <= .zero) && (self.collapsingViewHeightConstraint.constant != CollapsingConstant.collapsingViewHeight)  {

            self.updateCollapsingViewHeightConstraint(CollapsingConstant.collapsingViewHeight)
        }

        // Scrolling down
        if (scrollView.contentOffset.y > self.lastContentOffset) && self.collapsingViewHeightConstraint.constant != .zero {

            self.updateCollapsingViewHeightConstraint(.zero)
        }

        self.lastContentOffset = scrollView.contentOffset.y
    }
}

extension CollapsingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}


#if DEBUG
import SwiftUI

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ViewControllerRepresentable(target: CollapsingViewController())
    }
}
#endif
