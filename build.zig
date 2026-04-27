const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sheen = b.dependency("sheen", .{ .target = target, .optimize = optimize });
    const harfbuzz = b.dependency("harfbuzz", .{ .target = target, .optimize = optimize });
    const unibreak = b.dependency("unibreak", .{ .target = target, .optimize = optimize });
    const budouxc = b.dependency("budouxc", .{ .target = target, .optimize = optimize });
    const skb = b.dependency("Skribidi", .{});

    const mod = b.addModule("skribidi", .{
        .root_source_file = b.path("skribidi.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    mod.addIncludePath(skb.path("include"));
    const include_dirs = .{
        sheen.module("sheen").include_dirs.items,
        harfbuzz.module("harfbuzz").include_dirs.items,
        unibreak.module("unibreak").include_dirs.items,
        budouxc.module("budouxc").include_dirs.items,
    };
    inline for (include_dirs) |dirs| {
        for (dirs) |dir| mod.addIncludePath(dir.path);
    }

    mod.linkLibrary(sheen.artifact("sheen"));
    mod.linkLibrary(harfbuzz.artifact("harfbuzz"));
    mod.linkLibrary(unibreak.artifact("unibreak"));
    mod.linkLibrary(budouxc.artifact("budouxc"));
    mod.addCSourceFiles(.{
        .root = skb.path("src"),
        .files = &.{
            // "emoji_presentation_scanner.c",
            "skb_attribute_collection.c",
            "skb_attributes.c",
            "skb_canvas.c",
            "skb_common.c",
            "skb_editor.c",
            "skb_editor_rules.c",
            "skb_font_collection.c",
            "skb_icon_collection.c",
            "skb_image_atlas.c",
            "skb_layout.c",
            "skb_layout_cache.c",
            "skb_rasterizer.c",
            "skb_rich_layout.c",
            "skb_rich_text.c",
            "skb_text.c",
        },
        .flags = &.{},
    });

    const lib = b.addLibrary(.{ .name = "skribidi", .root_module = mod });
    b.installArtifact(lib);
}
