import MetalKit
class Node{
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        //do rendering here - as of right now, game object does not have values that we can use- want to call render on the game object, but want to seperate rendering out from game object.
        if let renderable = self as? Renderable{ //cast to renderable - if fail, will just skip over
            renderable.doRender(renderCommandEncoder)
    }
}
}
