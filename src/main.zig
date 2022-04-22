const std = @import("std");
const Allocator = std.mem.Allocator;
const Timer = std.time.Timer;

const forth = @import("untyped");
const gfx = @import("gfx.zig");

var heap_alloc = std.heap.c_allocator;
var vm: forth.VM = undefined;

pub fn main() !void {
    vm = try forth.VM.init(heap_alloc);
    defer vm.deinit();

    try gfx.init();
    defer gfx.deinit();
}
