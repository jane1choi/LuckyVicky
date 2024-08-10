//
//  SelectCharacterView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/22/24.
//

import SwiftUI

struct SelectCharacterView: View {
    @StateObject private var viewModel: SelectCharacterViewModel
    @State private var path = NavigationPath()
    
    init(viewModel: SelectCharacterViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 52)
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
                    .frame(maxHeight: 56)
                VStack(spacing: 15) {
                    ForEach(viewModel.state.characterList, id: \.self) { character in
                        characterCell(entity: character)
                    }
                }
                .padding(.horizontal, 29)
                
                Spacer()
                LuckyVickyButton(
                    title: "선택하기",
                    isActive: viewModel.state.selectedId != nil,
                    action: {
                        path.append(ConvertThoughtPath.inputTrouble)
                    }
                )
                .padding(.horizontal, 22)
                .padding(.bottom, 12)
                .navigationDestination(for: ConvertThoughtPath.self) { path in
                    switch path {
                    case .inputTrouble:
                        let viewModel = InputTroubleViewModel()
                        InputTroubleView(viewModel: viewModel, path: $path)
                    case .showResult:
                        let viewModel = ResultViewModel()
                        ResultView(viewModel: viewModel, path: $path)
                    }
                }
            }
            .background(Color(.mainBlack))
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
        .background(viewModel.state.selectedId == entity.id ? .mainGreen : .white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            viewModel.action(.onTapCharacterCell(id: entity.id))
        }
    }
    
}
