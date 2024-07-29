extends Benchmark

var tilemap_scene: PackedScene = preload("res://benchmarks/tilemap_colliders/scene_tilemap.tscn")
var single_sprites: Array[PackedScene] = [
    preload("res://benchmarks/tilemap_colliders/scene_single_node_0.tscn"),
    preload("res://benchmarks/tilemap_colliders/scene_single_node_1.tscn"),
    preload("res://benchmarks/tilemap_colliders/scene_single_node_2.tscn"),
    preload("res://benchmarks/tilemap_colliders/scene_single_node_3.tscn"),
    preload("res://benchmarks/tilemap_colliders/scene_single_node_4.tscn"),
    preload("res://benchmarks/tilemap_colliders/scene_single_node_5.tscn"),
    preload("res://benchmarks/tilemap_colliders/scene_single_node_6.tscn"),
    preload("res://benchmarks/tilemap_colliders/scene_single_node_7.tscn"),
]

func _init() -> void:
    test_render_cpu = true
    test_render_gpu = true
    test_idle = true
    test_physics = true
    benchmark_time = 5e6


func do_tile_map(size: Vector2i) -> TileMapLayer:
    var scene: TileMapLayer = tilemap_scene.instantiate()
    scene.collision_enabled = true
    scene.navigation_enabled = false
    
    for x in size.x:
        for y in size.y:
            var coords = Vector2i(x, y)
            var tile = randi_range(0, 7)
            scene.set_cell(coords, 0, Vector2i(0, 0), tile)
    
    return scene


func do_single_sprites(size: Vector2i) -> Node2D:
    var scene = Node2D.new()
    
    for x in size.x:
        for y in size.y:
            var coords = Vector2i(x, y)
            var idx = randi_range(0, 7)
            var child: Node2D = single_sprites[idx].instantiate()
            scene.add_child(child)
            child.position = coords * 32

    return scene

func benchmark_tilemap_128() -> TileMapLayer:
    return do_tile_map(Vector2i(128, 128))

func benchmark_single_sprites_128() -> Node2D:
    return do_single_sprites(Vector2i(128, 128))

func benchmark_tilemap_256() -> TileMapLayer:
    return do_tile_map(Vector2i(256, 256))

func benchmark_single_sprites_256() -> Node2D:
    return do_single_sprites(Vector2i(256, 256))
