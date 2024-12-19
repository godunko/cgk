--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Line segment in 2D space.

with CGK.Primitives.Axes_2D;
with CGK.Primitives.Points_2D;
with CGK.Reals;

package CGK.Primitives.Line_Segments_2D is

   pragma Pure;

   type Line_Segment_2D is private;

   function Create_Line_Segment_2D
     (Axis : CGK.Primitives.Axes_2D.Axis_2D;
      U1   : CGK.Reals.Real;
      U2   : CGK.Reals.Real) return Line_Segment_2D with Inline;

   function Point_1
     (Self : Line_Segment_2D) return CGK.Primitives.Points_2D.Point_2D;

   function Point_2
     (Self : Line_Segment_2D) return CGK.Primitives.Points_2D.Point_2D;

   function Middle
     (Self : Line_Segment_2D) return CGK.Primitives.Points_2D.Point_2D;

private

   type Line_Segment_2D is record
      Axis : CGK.Primitives.Axes_2D.Axis_2D;
      U1   : CGK.Reals.Real;
      U2   : CGK.Reals.Real;
   end record;

end CGK.Primitives.Line_Segments_2D;
