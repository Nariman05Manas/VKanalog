//
//  String + Height.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import UIKit

// Возвращает высоту, которую занимает текст, заданного размера
extension String {
    func height(textWidth: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: textWidth, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font],
                                     context: nil)
        return size.height
    }
    
    func truncated(after count: Int) -> String {
        let truncateAfter = index(startIndex, offsetBy: count)
        guard endIndex > truncateAfter else { return self }
        return String(self[startIndex..<truncateAfter]) + "…"
    }
}
