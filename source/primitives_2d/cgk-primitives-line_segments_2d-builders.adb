--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Directions_2D;
with CGK.Primitives.XYs;

package body CGK.Primitives.Line_Segments_2D.Builders is

   use CGK.Primitives.Axes_2D;
   use CGK.Primitives.Directions_2D;
   use CGK.Primitives.Points_2D;
   use CGK.Primitives.XYs;
   use CGK.Reals;

   -----------
   -- Build --
   -----------

   procedure Build
     (Self    : in out Line_Segment_2D_Builder;
      Point_1 : CGK.Primitives.Points_2D.Point_2D;
      Point_2 : CGK.Primitives.Points_2D.Point_2D)
   is
      D : constant Real := Distance (Point_1, Point_2);

   begin
     if D >= Resolution then
         Self.Segment :=
           Create_Line_Segment_2D
             (Create_Axis_2D
                (Point_1,
                 Create_Direction_2D
                   (Points_2D.XY (Point_2) - Points_2D.XY (Point_1))),
              0.0,
              D);
         Self.State := Valid;

      else
         Self.State := Confused_Points_Error;
      end if;
   end Build;

   ------------------
   -- Line_Segment --
   ------------------

   function Line_Segment
     (Self : Line_Segment_2D_Builder)
      return CGK.Primitives.Line_Segments_2D.Line_Segment_2D is
   begin
      Assert_Invalid_State_Error (Self.State = Valid);

      return Self.Segment;
   end Line_Segment;

end CGK.Primitives.Line_Segments_2D.Builders;
