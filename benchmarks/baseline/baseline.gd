extends Benchmark


func _init() -> void:
    test_render_cpu = true
    test_render_gpu = true
    test_idle = true
    test_physics = true
    benchmark_time = 5e6


func benchmark_baseline() -> Node:
    return Node.new()
