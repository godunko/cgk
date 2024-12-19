--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Directions_2D;
with CGK.Primitives.XYs;

package body CGK.Primitives.Line_Segments_2D is

   use CGK.Primitives.Axes_2D;
   use CGK.Primitives.Points_2D;
   use CGK.Primitives.XYs;
   use CGK.Reals;

   ----------------------------
   -- Create_Line_Segment_2D --
   ----------------------------

   function Create_Line_Segment_2D
     (Axis : CGK.Primitives.Axes_2D.Axis_2D;
      U1   : CGK.Reals.Real;
      U2   : CGK.Reals.Real) return Line_Segment_2D is
   begin
      return (Axis => Axis, U1 => U1, U2 => U2);
   end Create_Line_Segment_2D;

   ------------
   -- Middle --
   ------------

   function Middle
     (Self : Line_Segment_2D) return CGK.Primitives.Points_2D.Point_2D
   is
      U : constant Real := (Self.U1 + Self.U2) / 2.0;

   begin
      return
        Create_Point_2D
          (Points_2D.XY (Location (Self.Axis))
             + U * Directions_2D.XY (Direction (Self.Axis)));
   end Middle;

   -------------
   -- Point_1 --
   -------------

   function Point_1
     (Self : Line_Segment_2D) return CGK.Primitives.Points_2D.Point_2D is
   begin
      return
        Create_Point_2D
          (Points_2D.XY (Location (Self.Axis))
             + Self.U1 * Directions_2D.XY (Direction (Self.Axis)));
   end Point_1;

   -------------
   -- Point_2 --
   -------------

   function Point_2
     (Self : Line_Segment_2D) return CGK.Primitives.Points_2D.Point_2D is
   begin
      return
        Create_Point_2D
          (Points_2D.XY (Location (Self.Axis))
             + Self.U2 * Directions_2D.XY (Direction (Self.Axis)));
   end Point_2;

end CGK.Primitives.Line_Segments_2D;
