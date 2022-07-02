//
//  AppIconCell.swift
//  IconPicker
//

#if os(iOS)

import Color
import ConstraintKit
import UIKit
import NPKit

class AppIconCell: UICollectionViewCell {
	private let outlineView: NPView = {
		let view = NPView()
		view.backgroundColor = Color.systemBlue
		view.layer.cornerCurve = CALayerCornerCurve.continuous
		return view
	}()

	private let fillView: NPView = {
		let view = NPView()
		view.backgroundColor = Color.systemBackground
		view.layer.cornerCurve = CALayerCornerCurve.continuous
		return view
	}()

	private let imageView: NPImageView = {
		let view = NPImageView()
		view.clipsToBounds = true
		view.layer.cornerCurve = CALayerCornerCurve.continuous
		return view
	}()

	public override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(self.outlineView)
		self.addSubview(self.fillView)
		self.addSubview(self.imageView)

		NSLayoutConstraint.activate(
			self.outlineView.fillSuperview(inset: 0) +
			self.fillView.fillSuperview(inset: 2) +
			self.imageView.fillSuperview(inset: 4)
		)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setImage(_ image: UIImage, size: Double) {
		let radius = size / 4.0;
		self.imageView.image = image
		self.imageView.layer.cornerRadius = radius
		self.fillView.layer.cornerRadius = radius + 2
		self.outlineView.layer.cornerRadius = radius + 4
	}

	func setSelected(_ selected: Bool) {
		self.outlineView.isHidden = !selected
	}
}

#endif
