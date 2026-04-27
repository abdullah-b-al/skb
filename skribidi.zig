pub const c = @cImport({
    @cInclude("skb_attribute_collection.h");
    @cInclude("skb_attributes.h");
    @cInclude("skb_canvas.h");
    @cInclude("skb_common.h");
    @cInclude("skb_editor.h");
    @cInclude("skb_editor_rules.h");
    @cInclude("skb_font_collection.h");
    @cInclude("skb_icon_collection.h");
    @cInclude("skb_image_atlas.h");
    @cInclude("skb_layout.h");
    @cInclude("skb_layout_cache.h");
    @cInclude("skb_rasterizer.h");
    @cInclude("skb_rich_layout.h");
    @cInclude("skb_rich_text.h");
    @cInclude("skb_text.h");
});
