//
//  ToDoListHeaderView.swift
//  to-do list app
//
//  Created by 농협 on 02/04/2020.
//  Copyright © 2020 nonghyup. All rights reserved.
//

import UIKit

enum Weekday: Int {
    case 일, 월, 화, 수, 목, 금, 토
}

struct DayInfo {
    var week: String
    var day: Int
}

class ToDoListHeaderView: UIView {
    
//    var currentIdx: Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel! {
        
        didSet {
            dateLabel.text = currentDate()
        }
    }
    
//    private let itemSize = CGSize(width: 50, height: 70)
    
    var dayCountOfMonth: Int {
        return Calendar.current.range(of: .day, in: .month, for: firstDay!)?.count ?? 0
    }
    
    var firstDay: Date? {
        
        let date = Date()
        let calendar = Calendar.current
        
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: date)))
        
        return startOfMonth
    }
    
    var currentDay: Int {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        
        return components.day!
    }
    
    private var dayInfos = [DayInfo]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed("ToDoListHeaderView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func currentDate() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE yyyy"
        return formatter.string(from: date) // Oct 2019
    }
    
    func snapToNearestCell(_ collectionView: UICollectionView) {
        for i in 0..<collectionView.numberOfItems(inSection: 0) {

            let itemWithSpaceWidth: CGFloat = 50.0 + 20.0
            let itemWidth: CGFloat = 50.0

            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
                let indexPath = IndexPath(item: i, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                break
            }
        }
    }
    
    func updateInit() {
        
        self.setDayInfos()
        
        collectionView.register(UINib(nibName: "CalendalCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.setCollectionViewContentOffset()
    }
    
    func setDayInfos() {
        
        var firstWeekday = Calendar.current.component(.weekday, from: self.firstDay!)
        
        for i in 1...self.dayCountOfMonth {
            
            dayInfos.append(DayInfo(week: "\(Weekday(rawValue: firstWeekday - 1)!)", day: i))
            
            firstWeekday += 1
            
            if firstWeekday > 7 {
                
                firstWeekday = 1
            }
        }
    }
    
    func setCollectionViewContentOffset() {
        
//        var sum: CGFloat = 0.0
//        var positionFromObject: CGFloat!
//
//        let wid = self.collectionView.frame.width
//
//        for i in 1...self.dayCountOfMonth {
//
//            sum += (20.0 + 50.0)
//
//            if sum > (wid / 2) {
//
//                positionFromObject = CGFloat(self.currentDay - i) * (20.0 + 50.0)
//                break
//            }
//        }
//
//        let attributes = self.collectionView.layoutAttributesForItem(at: IndexPath(row: self.currentDay - 1, section: 0))
//        if let attr = attributes {
//
//            if attr.frame.origin.x >= wid / 2 {
//
//                self.collectionView.contentOffset = CGPoint(x: positionFromObject, y: self.collectionView.contentOffset.y)
//            }
//        }
        
//        let attributes = self.collectionView.layoutAttributesForItem(at: IndexPath(row: self.currentDay - 1, section: 0))
//        if let attr = attributes {
//
//            let re = attr.frame.origin.x - (self.collectionView.frame.width / 2) + 50.0
//            self.collectionView.contentOffset = CGPoint(x: re, y: self.collectionView.contentOffset.y)
//        }
        
        let attributes = self.collectionView.layoutAttributesForItem(at: IndexPath(row: currentDay - 1, section: 0))
        if let attr = attributes {
            
            let midX: CGFloat = collectionView.bounds.size.width / 2
            let re1 = (attr.frame.origin.x + midX) - collectionView.frame.width
//            let re2 = re1 / 2 - (attr.frame.origin.x + midX)
//            let re3 = re2 / 2 - midX // 493
//            let closestAttribute = attr.frame.origin.x + midX
            self.collectionView.contentOffset = CGPoint(x: re1 + 50.0, y: attr.frame.origin.y)
        }
        
        collectionView.reloadData()
    }
    
//    func snapToCenter() {
//        let centerPoint = self.convert(self.center, to: collectionView)
//        let centerIndexPath = collectionView.indexPathForItem(at: centerPoint)!
//        collectionView.scrollToItem(at: centerIndexPath, at: .centeredVertically, animated: true)
//    }
}

extension ToDoListHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalendalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendalCell
        
        if (indexPath.row + 1) == currentDay {
            cell.backgroundColor = UIColor(red: 58 / 255, green: 50 / 255, blue: 188 / 255, alpha: 1.0)
            cell.dayLabel.textColor = .white
        } else {
            cell.backgroundColor = .white
            cell.dayLabel.textColor = UIColor(red: 58 / 255, green: 50 / 255, blue: 188 / 255, alpha: 1.0)
        }
        
        cell.dayLabel.text = "\(dayInfos[indexPath.row].day)"
        cell.weekLabel.text = "\(dayInfos[indexPath.row].week)"
        return cell
    }
    
}

//extension ToDoListHeaderView: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = 50.0 * 30 // 80 * collectionView.numberOfItems(inSection: 0)
//        let totalSpacingWidth = 20.0 * 8 // 10 * (collectionView.numberOfItems(inSection: 0) - 1)
//
//        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
//    }
//}

//extension ToDoListHeaderView: UIScrollViewDelegate {
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        self.snapToNearestCell(collectionView)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.snapToNearestCell(collectionView)
//    }
//}
