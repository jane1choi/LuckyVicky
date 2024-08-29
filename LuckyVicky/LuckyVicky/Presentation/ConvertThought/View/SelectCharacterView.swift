//
//  SelectCharacterView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/22/24.
//

import SwiftUI

struct SelectCharacterView: View {
    @StateObject private var viewModel: SelectCharacterViewModel
    
    init(viewModel: SelectCharacterViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            LuckyVickyNavigationBar(
                rightItemList: [(
                    LuckyVickyImage.setting, {
                        viewModel.action(.onTapSettingButton)
                    }
                )]
            )
            .padding(.bottom, 8)
            
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
            
            VStack(spacing: 15) {
                ForEach(viewModel.state.characterList, id: \.self) { character in
                    characterCell(entity: character)
                }
            }
            .padding(.horizontal, 29)
            
            Spacer()
            Text("오늘 이용 횟수 \(viewModel.state.chanceCount)/10")
                .font(.pretendardM(12))
                .foregroundStyle(.white)
                .padding(.bottom, 18)
            
            LuckyVickyButton(
                title: "선택하기",
                isActive: viewModel.state.selectedId != nil,
                action: {
                    viewModel.action(.onTapSelectButton)
                }
            )
            .padding(.horizontal, 22)
            .padding(.bottom, 12)
            
        }
        .background(Color(.mainBlack))
        .navigationBarBackButtonHidden(true)
        .overlay {
            LoadingView()
                .hidden(!viewModel.state.isLoading)
        }
        .onAppear {
            viewModel.action(.onAppear)
        }
        .presentAlert(isPresented: $viewModel.state.isAlertPresented) {
            LuckyVickyAlertView(isPresented: $viewModel.state.isAlertPresented,
                                message: "오늘 이용권을 모두 사용했습니다.\n내일 다시 이용해주세요.")
        }
        .presentAlert(isPresented: $viewModel.state.isDeleteAccountAlertPresented) {
            LuckyVickyAlertView(type: .twoButton,
                                isPresented: $viewModel.state.isDeleteAccountAlertPresented,
                                title: "정말로 계정을 삭제하시겠습니까?",
                                message: "회원 정보는 안전하게 삭제되며,\n언제든 다시 가입할 수 있습니다.",
                                action: { viewModel.action(.onTapdeleteAccountButton)})
        }
        .presentAlert(isPresented: $viewModel.state.hasErrorOccurred) {
            LuckyVickyAlertView(isPresented: $viewModel.state.hasErrorOccurred,
                                message: "네트워크 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.")
        }
    }
    
    
    @ViewBuilder
    func characterCell(entity: CharacterEntity) -> some View {
        
        HStack(alignment: .center) {
            Image(entity.iconImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100 * (screenSize?.width ?? 0) / 375,
                       height: 82 * ((screenSize?.height ?? 0) / 812))
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
        .background(viewModel.state.selectedId == entity.id ? .mainGreen : .white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            viewModel.action(.onTapCharacterCell(id: entity.id))
        }
    }
}

