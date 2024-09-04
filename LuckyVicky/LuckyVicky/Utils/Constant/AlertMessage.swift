//
//  AlertMessage.swift
//  LuckyVicky
//
//  Created by EUNJU on 9/4/24.
//

import Foundation

enum AlertMessage: String {
    case networkError = "네트워크 오류가 발생했습니다.\n잠시 후 다시 시도해주세요."
    case exhaustedChance = "오늘 이용권을 모두 사용했습니다.\n내일 다시 이용해주세요."
    case deleteAccountTitle = "정말로 계정을 삭제하시겠습니까?"
    case deleteAccount = "회원 정보는 안전하게 삭제되며,\n언제든 다시 가입할 수 있습니다."
    case imagehasSaved = "이미지가 사진 앨범에\n저장되었습니다."
    case imageSaveError = "이미지 저장에 실패했습니다.\n다시 시도해주세요"
    
    var description: String {
        return rawValue
    }
}
