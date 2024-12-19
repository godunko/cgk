--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Advanced algorithms to create Line_Segment_2D.

package CGK.Primitives.Line_Segments_2D.Builders is

   pragma Pure;

   type Line_Segment_2D_Builder is private;

   procedure Build
     (Self    : in out Line_Segment_2D_Builder;
      Point_1 : CGK.Primitives.Points_2D.Point_2D;
      Point_2 : CGK.Primitives.Points_2D.Point_2D);

   function Line_Segment
     (Self : Line_Segment_2D_Builder)
      return CGK.Primitives.Line_Segments_2D.Line_Segment_2D;

private

   type Line_Segment_2D_Builder is record
      State   : CGK.Primitives.Builder_State_Kind := CGK.Primitives.Invalid;
      Segment : Line_Segment_2D;
   end record;

end CGK.Primitives.Line_Segments_2D.Builders;
