set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M1 -stop_x 0 -stop_y 0 -width 2 -area {} -nets {GND VDD} -start_x 0 -stacked_via_bottom_layer M1 -start_y 0
editPushUndo
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M1 -stop_x 0 -stop_y 0 -width 2 -area {} -nets {GND VDD} -start_x 0 -stacked_via_bottom_layer M1 -start_y 0
editPushUndo
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M1 -stop_x 0 -stop_y 0 -width 2 -area {} -nets {GND VDD} -start_x 0 -stacked_via_bottom_layer M1 -start_y 0
