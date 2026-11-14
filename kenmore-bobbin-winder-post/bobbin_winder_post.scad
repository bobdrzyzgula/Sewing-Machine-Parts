// bobbin_winder_post.scad
// Replacement bobbin-winder stop post for Kenmore 385-series (Janome-built)
// sewing machines, e.g. Kenmore 385.1584180.
//
// Designed by Bob Drzyzgula. This file is a reconstruction of his original,
// unsaved model, written by Claude (Anthropic) at his direction from his
// exported STL; it reproduces that STL's geometry.
//
// License: MIT (see LICENSE)
//
// Geometry: a small round post and a larger round flange on offset axes,
// with an M4 socket-head cap-screw hole (BOSL2) down the post's axis and a
// counterbore for the screw head in the flange's large face.
//
// Requires BOSL2: https://github.com/BelfrySCAD/BOSL2

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

/* [Post (the small cylinder; the screw runs down its axis)] */
// Post diameter (mm)
post_diameter = 7.6;    // [4:0.1:12]
// Post height (mm)
post_height = 5.9;      // [1:0.1:15]

/* [Flange (the large cylinder)] */
// Flange diameter (mm)
flange_diameter = 15.6; // [8:0.1:30]
// Flange thickness (mm)
flange_thickness = 4.9; // [1:0.1:15]
// Offset of the flange axis from the post/screw axis (mm)
flange_offset = 3.0;    // [0:0.1:10]

/* [Screw hole] */
// Screw spec passed to BOSL2 screw_hole()
screw_spec = "M4";
// Depth of the counterbore for the socket head, in the flange face (mm)
counterbore_depth = 2.3; // [0:0.1:8]
// Extra diameter added to the 7 mm socket head for its counterbore (mm); 1.5 gives an 8.5 mm bore
head_oversize = 1.5;    // [0:0.1:3]

/* [Output] */
// Flip so the large flange face is on the bed (the way it was printed)
print_orientation = true;

/* [Hidden] */
$fn = 100;
total_height = post_height + flange_thickness;

module bobbin_winder_post() {
    difference() {
        union() {
            cyl(d = post_diameter, h = post_height, anchor = BOTTOM);
            right(flange_offset)
                up(post_height)
                    cyl(d = flange_diameter, h = flange_thickness, anchor = BOTTOM);
        }
        // Screw hole down the post axis, head counterbored into the flange face
        up(total_height)
            screw_hole(screw_spec, head = "socket",
                       counterbore = counterbore_depth,
                       head_oversize = head_oversize,
                       length = total_height + 1,
                       anchor = TOP);
    }
}

if (print_orientation)
    up(total_height) xrot(180) bobbin_winder_post();
else
    bobbin_winder_post();
