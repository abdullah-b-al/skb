const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sheen = b.dependency("SheenBidi", .{ .target = target, .optimize = optimize });
    const mod = b.addModule("sheen", .{
        .root_source_file = b.path("sheen.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    mod.addIncludePath(sheen.path("Headers"));
    mod.addIncludePath(sheen.path("Source"));
    mod.addCSourceFile(.{
        .file = sheen.path("Source/SheenBidi.c"),
        .flags = &.{ "-ansi", "-DSB_CONFIG_UNITY" },
    });

    const lib = b.addLibrary(.{ .name = "sheen", .root_module = mod });
    b.installArtifact(lib);
}
