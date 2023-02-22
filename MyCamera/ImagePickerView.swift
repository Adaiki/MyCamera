//
//  ImagePickerView.swift
//  MyCamera
//
//  Created by 赤荻大輝 on 2023/01/21.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    //UIImagePickerController(写真撮影）が表示されているかを確認
    @Binding var isShowSheet: Bool
    //撮影した写真を格納する変数
    @Binding var captureImage: UIImage?
    
    //Coordinaterでコントローラのdelegateを管理
    class Coordinator: NSObject,
                       UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {
        // ImagePickerView型の定数を用意
        let parent: ImagePickerView
        
        //イニシャライザ
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        //撮影が終わったときに呼ばれるdelegateメソッド、必ず必要
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
            //撮影した写真をcaptureImageに保存
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.captureImage = originalImage
            }
            
            //sheetを閉じる
            parent.isShowSheet.toggle()
        }
        
        //キャンセルボタンが選択されたときに呼ばれるdelegateメソッド、必ず選択
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            //parent.isShowSheet.toggle()
        }
    } //Coodinater ここまで
    
    // Cordinatorを生成。SwiftUIによって自動的に呼び出し
    func makeCoordinator() -> Coordinator {
        //Coordinatorクラスのインスタンスを生成
        Coordinator(self)
    }
    
    //Viewを生成するときに実行
    func makeUIViewController(context: Context) -> UIImagePickerController {
        //UIImagePickerControllerのインスタンスを生成
        let myImagePickerController = UIImagePickerController()
        //sourceTypeにcameraを設定
        myImagePickerController.sourceType = .camera
        //delegate設定
        myImagePickerController.delegate = context.coordinator
        //UIImagePickerControllerを返す
        return myImagePickerController
    }//makeUIViewController こまで
    
    //Viewが実行されたときに実行
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //処理なし
    }//updateUIViewControllerここまで
} //ImagePickerView ここまで
