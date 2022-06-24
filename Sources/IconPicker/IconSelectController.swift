//
//  AppIconController.swift
//  IconPicker
//

#if os(iOS)

import NPKit
import UIKit

private let AppIconCellIdentifier = "AppIconCell"

private let IconSize = 60.0
private let IconPadding = 4.0 + 4.0
private let IconFullSize = IconSize + IconPadding
private let IconsPerLine = 4.0
private let SpacesPerLine = IconsPerLine + 1
private let IconWidthPerLine = IconsPerLine * IconFullSize

public class AppIconController<T: AppIconType>: NPCollectionViewController, UICollectionViewDelegateFlowLayout {
	private var currentIconIndex = T.currentIndex()

	public override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.largeTitleDisplayMode = .never
		self.navigationItem.title = NSLocalizedString("ChangeAppIcon", comment: "")

		self.collectionView.register(AppIconCell.self, forCellWithReuseIdentifier: AppIconCellIdentifier)
	}

	private func hightlightSelectedIcon(old: Int, new: Int) {
		if let oldCell = self.collectionView.cellForItem(at: IndexPath(row: old, section: 0)) as? AppIconCell {
			oldCell.setSelected(false)
		}
		if let newCell = self.collectionView.cellForItem(at: IndexPath(row: new, section: 0)) as? AppIconCell {
			newCell.setSelected(true)
		}
	}

	// MARK: UICollectionViewDataSource

	public override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1 + T.allCases.count
	}

	public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let row = indexPath.row
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppIconCellIdentifier, for: indexPath) as! AppIconCell
		cell.setSelected(self.currentIconIndex == row)
		cell.setImage(T.imageFrom(index: row), size: IconSize)
		return cell
	}

	// MARK: UICollectionViewDelegate

	public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let oldIconIndex = self.currentIconIndex
		self.currentIconIndex = indexPath.row
		self.hightlightSelectedIcon(old: oldIconIndex, new: self.currentIconIndex)

		T.setCurrentIndex(indexPath.row) { err in
			if let err = err {
				let alertController = UIAlertController(title: NSLocalizedString("IconChangeFailure", comment: ""), message: err.localizedDescription, preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .default))
				self.present(alertController, animated: true, completion: nil)

				self.hightlightSelectedIcon(old: self.currentIconIndex, new: oldIconIndex)
				self.currentIconIndex = oldIconIndex
			}
		}
	}

	// MARK: UICollectionViewDelegateFlowLayout

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: IconFullSize, height: IconFullSize)
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let space = self.collectionView.frame.size.width - IconWidthPerLine
		let inset = space / SpacesPerLine
		return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		let space = self.collectionView.frame.size.width - IconWidthPerLine
		return space / SpacesPerLine
	}
}

#endif
