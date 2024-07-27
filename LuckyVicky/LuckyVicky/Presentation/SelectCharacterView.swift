//
//  SelectCharacterView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/22/24.
//

import SwiftUI

struct SelectCharacterView: View {
    
    var body: some View {
        ZStack {
            Color(.mainBlack).ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("오늘 하루\n힘든 일이 있었나요?")
                            .font(.pretendardSB(22))
                            .foregroundStyle(.white)
                            .lineSpacing(10)
                            .padding(.bottom, 15)
                        Text("다른 사고 방식으로 생각해보며 털어버리는건 어떨까요?")
                            .font(.pretendardM(12))
                            .foregroundStyle(.white)
                    }
                    .padding(.leading, 28)
                    Spacer()
                }

                Spacer()
                LazyVStack {
                    characterCell(entity: CharacterEntity(id: 0, name: "원영", introduction: "완전 럭키비키잖앙~", imageName: .wonyoung))
                    characterCell(entity: CharacterEntity(id: 1, name: "희진", introduction: "맞다이로 들어와", imageName: .heejin))
                    characterCell(entity: CharacterEntity(id: 2, name: "우희", introduction: "얼마나 잘 되려고 이럴까?", imageName: .woohee))
                    characterCell(entity: CharacterEntity(id: 3, name: "흥민", introduction: "그냥 좋다고 생각하면 돼.", imageName: .heungmin))
                    
                }
                .padding(.horizontal, 29)
                
                Spacer()
                LuckyVickyButton(title: "선택하기",
                                 action: {})
                .padding(.horizontal, 22)
            }
        }
    }
    
    @ViewBuilder 
    func characterCell(entity: CharacterEntity) -> some View {
        
        HStack(alignment: .center) {
            Image(entity.imageName)
                .frame(width: 100, height: 82)
                .padding(.top, 4)
                .padding(.leading, 25)
                .padding(.trailing, 28)
            
            VStack(alignment: .leading) {
                Text(entity.introduction)
                    .font(.pretendardM(12))
                    .lineLimit(1)
                Text("\(entity.name)적 사고")
                    .font(.pretendardSB(20))
                    .padding(.top, 1)
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SelectCharacterView()
}
