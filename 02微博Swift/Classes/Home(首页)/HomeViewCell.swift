//
//  HomeViewCell.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/6.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

private let edgeMargin : CGFloat = 15
private let itemMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {

    // MARK:- 控件属性
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var picViewWidthCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHeightCons: NSLayoutConstraint!
    
    
    @IBOutlet weak var contentLabelWCons: NSLayoutConstraint!
    
    var viewModel : StatusViewModel?{
        didSet{
            // 1.nil值校验
            guard let viewModel = viewModel else {
                return
            }
            
            // 2.设置头像
            iconView.sd_setImage(with: viewModel.profileURL as URL?, placeholderImage: UIImage(named: "avatar_default_small"))
            
            // 3.设置认证的图标
            verifiedView.image = viewModel.verifiedImage
            
            // 4.昵称
            screenNameLabel.text = viewModel.status.user?.screen_name
            
            // 5.会员图标
            vipView.image = viewModel.vipImage
            
            // 6.设置时间的Label
            timeLabel.text = viewModel.createAtText
            
            // 7.设置来源
            sourceLabel.text = viewModel.sourceText
            
            contentLabel.text = viewModel.status.text
            
            // 8.设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            
            // 9.计算配图视图的宽度跟高度约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWidthCons.constant = picViewSize.width
            picViewHeightCons.constant = picViewSize.height
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //设置微博正文的宽度
        contentLabelWCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
}
}

// MARK:- 计算方法
extension HomeViewCell{
    
    fileprivate func calculatePicViewSize(count : Int) -> CGSize{
        
        //没有配图
        if count == 0 {
            return CGSize.zero
        }
        //计算出imageView的尺寸
        let imageViewWH = (UIScreen.main.bounds.size.width - 2 * edgeMargin - 2 * itemMargin)/3
        //4张配图
        if count == 4{
            
            let picViewWH = imageViewWH  * 2 + itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        //其他配图
        let rows = CGFloat((count - 1)/3 + 1)
        
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        
        let picViewW = UIScreen.main.bounds.size.width - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
    }
    
}
