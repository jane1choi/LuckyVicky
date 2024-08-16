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
                        if !viewModel.state.isAlertPresented {
                            path.append(ConvertThoughtPath.inputTrouble)
                        }
                    }
                )
                .padding(.horizontal, 22)
                .padding(.bottom, 12)
                .navigationDestination(for: ConvertThoughtPath.self) { path in
                    switch path {
                    case .inputTrouble:
                        let service = GptAPIService()
                        let gptRepository = GptRepositoryImpl(apiService: service)
                        let userRepository = UserDBRepositoryImpl()
                        let useCase = ConvertTroubleUseCaseImpl(gptRepository: gptRepository,
                                                                userRepository: userRepository)
                        let viewModel = InputTroubleViewModel(useCase: useCase)
                        InputTroubleView(viewModel: viewModel, path: $path)
                    case .showResult(let userInput, let result):
                        let viewModel = ResultViewModel()
                        ResultView(viewModel: viewModel, 
                                   path: $path,
                                   inputText: userInput, 
                                   result: result)
                    }
                }
                .presentAlert(isPresented: $viewModel.state.isAlertPresented) {
                    LuckyVickyAlertView(isPresented: $viewModel.state.isAlertPresented,
                                        message: "오늘 이용 가능 횟수를\n모두 소진했습니다.")
                }
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

