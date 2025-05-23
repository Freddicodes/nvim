local source = {}

source.new = function()
    return setmetatable({}, { __index = source })
end

source.complete = function(self, request, callback)
    local input = request.context.cursor_before_line

    if not input:match("nnd$") then
        callback({})
        return
    end

    callback({
        {
            label = "nnd",
            insertText = [[
import rclpy
from rclpy.node import Node

class MyNode(Node):
    def __init__(self):
        super().__init__('my_node')
        self.get_logger().info('Node has been started')

def main(args=None):
    rclpy.init(args=args)
    node = MyNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
]],
            kind = vim.lsp.protocol.CompletionItemKind.Snippet,
            documentation = {
                kind = "markdown",
                value = "ROS 2 Python node template"
            },
            insertTextFormat = 2, -- 2 = Snippet format
        },
    })
end

source.get_keyword_pattern = function()
    return [[\k\+]]
end

return source
