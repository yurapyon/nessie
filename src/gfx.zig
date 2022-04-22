const c = @import("c.zig");

const GfxError = error{
    glfw_init,
    window_init,
};

pub const Program = struct {
    prog: u32,
    locations: Locations,
};

pub const Locations = struct {
    const Self = @This();

    screen: c.GLint,
    view: c.GLint,
    model: c.GLint,
    time: c.GLint,
    flip_uvs: c.GLint,
    diffuse: c.GLint,
    base_color: c.GLint,

    pub fn fill(self: *Self, prog: u32) void {
        self.screen = c.glGetUniformLocation(prog, "_screen");
        self.view = c.glGetUniformLocation(prog, "_view");
        self.model = c.glGetUniformLocation(prog, "_model");
        self.time = c.glGetUniformLocation(prog, "_time");
        self.flip_uvs = c.glGetUniformLocation(prog, "_flip_uvs");
        self.diffuse = c.glGetUniformLocation(prog, "_diffuse");
        self.base_color = c.glGetUniformLocation(prog, "_base_color");
    }
};

var current_locations: *const Locations = undefined;

pub fn bindProgram(prog: *const Program) void {
    c.useProgram(prog.prog);
    current_locations = &prog.locations;
}

pub fn setBaseColor(color: [4]f32) void {
    c.uniform4fv(current_locations.base_color, color);
}

var quad_vbo: c.GLuint = undefined;

pub fn init() !void {
    const quad_verts = [16]f32{
        1.0, 1.0, 1.0, 1.0,
        0.0, 1.0, 0.0, 1.0,
        1.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 0.0,
    };
    c.glBindBuffer(c.GL_ARRAY_BUFFER, quad_vbo);
    _ = quad_verts;
    // c.glBufferData( c.GL_ARRAY_BUFFER, &quad_verts, @sizeOf(quad_verts), c.GL_STATIC_DRAW,);
}

pub fn deinit() void {}

pub fn drawQuad() void {}

pub fn initSpritebatch() void {}

pub fn deinitSpritebatch() void {}
