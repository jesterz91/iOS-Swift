//
//  ViewController.swift
//  BottomSheet
//
//  Created by lee on 2021/06/12.
//

import UIKit

final class ViewController: UIViewController {

    private let button: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("show", for: .normal)
        view.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc private func showBottomSheet() {
        switch (1...10).randomElement()! % 4 {
        case 0:
            showOneButtonModal()
        case 1:
            showOneButtonModalWithSubtitle()
        case 2:
            showTwoButtonModal()
        default:
            showTwoButtonModalWithSubtitle()
        }
    }

    private func showOneButtonModal() {
        BottomSheet.shared.show(
            title: "회원정보가 수정되었습니다.",
            onPositive: {
                print("수정 확인")
            }
        )
    }

    private func showOneButtonModalWithSubtitle() {
        BottomSheet.shared.show(
            title: "초대 코드가 생성되었습니다.",
            subtitle: "친구에게 소개해 보세요."
        )
    }

    private func showTwoButtonModal() {
        BottomSheet.shared.show(
            title: "로그아웃 하시겠습니까?",
            onPositive: {
                print("로그아웃 확인")
            },
            onNegative: {
                print("로그아웃 취소")
            }
        )
    }

    private func showTwoButtonModalWithSubtitle() {
        BottomSheet.shared.show(
            title: "정말 탈퇴 하시겠어요?",
            subtitle: "탈퇴 시, 모든 정보가 삭제됩니다.\n포인트 및 쿠폰은 더 이상 사용하실 수 없습니다.",
            onPositive: {
                print("탈퇴 확인")
            },
            onNegative: {
                print("탈퇴 취소")
            }
        )
    }
}
