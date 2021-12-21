import MetalKit

protocol Renderable{
    //can make renderable for collider - colladable - do collision, etc
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
