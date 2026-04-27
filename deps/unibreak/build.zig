const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const unibreak = b.dependency("unibreak", .{});

    const mod = b.addModule("unibreak", .{
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    mod.addIncludePath(unibreak.path("src"));
    mod.addCSourceFiles(.{
        .root = unibreak.path("src"),
        .files = &.{
            "eastasianwidthdata.c",
            "eastasianwidthdef.c",
            "emojidata.c",
            "emojidef.c",
            "graphemebreak.c",
            "graphemebreakdata.c",
            "indicconjunctbreakdata.c",
            "linebreak.c",
            "linebreakdata.c",
            "linebreakdef.c",
            "unibreakbase.c",
            "unibreakdef.c",
            "wordbreak.c",
            "wordbreakdata.c",
        },
        .flags = &.{},
    });

    const lib = b.addLibrary(.{ .name = "unibreak", .root_module = mod });
    b.installArtifact(lib);
}
