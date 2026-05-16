extends StateBase
class_name StateBasePlayer

var player: Player:
    set (value):
        controlled_node = value
    get:
        return controlled_node
