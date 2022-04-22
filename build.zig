const std_build = @import("std").build;
const Builder = std_build.Builder;
const Pkg = std_build.Pkg;

const pkg_untyped = Pkg{
    .name = "untyped",
    .path = std_build.FileSource.relative("lib/untyped/src/lib.zig"),
};

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    // TODO
    //   handle building on windows =)

    const exe = b.addExecutable("tanagrams", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);

    exe.addPackage(pkg_untyped);

    exe.addIncludeDir("/usr/include");

    exe.addIncludeDir("deps/stb");
    exe.addCSourceFile("deps/stb/stb_image.c", &[_][]const u8{"-std=c99"});

    exe.addLibPath("/usr/lib");
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("glfw");
    exe.linkSystemLibrary("epoxy");
    exe.linkSystemLibrary("portaudio");

    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
