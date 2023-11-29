//
//  ContentView.swift
//  QiitaCoreData
//
//  Created by 澤木柊斗 on 2023/11/29.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.memo, ascending: true)],
        animation: .default)
    private var memoList: FetchedResults<Memo>
    @State private var memoString: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("メモを入力", text: $memoString)
                    .frame(width: 300, height: 60)
                Button(action: {addItem(memoString: memoString)}, label: {
                    Text("追加")
                })
            }
                List {
                    ForEach(memoList) { item in
                        Text(item.memo ?? "")
                    }
                    .onDelete(perform: deleteItems)
                }

        }
        }


    private func addItem(memoString: String) {
        withAnimation {
            //Memoエンティティのインスタンスを初期化
            let newMemo = Memo(context: viewContext)
            newMemo.memo = memoString

            do {
                //データを保存
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { memoList[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    }
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
