import Foundation
import UIKit
import Render

// from https://github.com/alexdrone/Render/issues/34

struct TableComponentViewState: StateType {
  let number: Int = 100
}

class TableComponentView: ComponentView<TableComponentViewState> {

  required init() {
    super.init()
    self.state = TableComponentViewState()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Not supported")
  }
  
  override func render() -> NodeType {

    let size = self.size()

    let list = TableNode() { (view, layout, size) in
      layout.width = size.width
      layout.height = size.height
      view.backgroundColor = Color.black
      view.separatorStyle = .none
    }

    let basicNodeFragments = [

      // Any node definition will be wrapped inside a UITableViewCell.
      Node<UIView>(key: "green") { (view, layout, size) in
        layout.width = size.width
        layout.height = 300
        view.backgroundColor = Color.green
      },

      Node<UIView>(key: "red") { (view, layout, size) in
        layout.width = size.width
        layout.height = 100
        view.backgroundColor = Color.red
      },

      // A node definition.
      Node<UIView>(key: "darkerGreen") { (view, layout, size) in
        layout.width = size.width
        layout.height = 300
        view.backgroundColor = Color.darkerGreen
      }
    ]

    let helloWorldFragments = (1..<state.number).map { index in
      ComponentNode(HelloWorldComponentView(), in: self)
    }

    list.add(children: basicNodeFragments + helloWorldFragments)
    return list
  }

}

class Example4ViewController: ViewController, ComponentViewDelegate {

  private let component = TableComponentView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(component)
    component.delegate = self
  }

  func componentDidRender(_ component: AnyComponentView) {
    component.center = view.center
  }
}

