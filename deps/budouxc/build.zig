const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const bud = b.dependency("budouxc", .{});
    const mod = b.addModule("budouxc", .{
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    mod.addCSourceFiles(.{
        .root = bud.path("src"),
        .files = &.{"budoux.c"},
        .flags = &.{},
    });

    mod.addIncludePath(bud.path("include"));
    const lib = b.addLibrary(.{ .name = "budouxc", .root_module = mod });
    b.installArtifact(lib);
}
