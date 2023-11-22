//
//  Ext Table.swift
//  The 1000 Game
//
//  Created by Sanchez on 21.11.2023.
//

import UIKit

extension UITableView {
    func reloadDataWithAnimation(duration: TimeInterval = 0.3, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        UIView.transition(with: self, duration: duration, options: options, animations: {
            self.reloadData()
        }, completion: { _ in
            completion?()
        })
    }

    func reloadSectionsWithAnimation(sections: IndexSet, duration: TimeInterval = 0.3, options: UITableView.RowAnimation = .automatic, completion: (() -> Void)? = nil) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.reloadSections(sections, with: options)
        }, completion: { _ in
            completion?()
        })
    }

    func reloadRowsWithAnimation(at indexPaths: [IndexPath], duration: TimeInterval = 0.3, options: UITableView.RowAnimation = .automatic, completion: (() -> Void)? = nil) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.reloadRows(at: indexPaths, with: options)
        }, completion: { _ in
            completion?()
        })
    }
}


