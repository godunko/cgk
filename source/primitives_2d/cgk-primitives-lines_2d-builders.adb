--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.XYs;

package body CGK.Primitives.Lines_2D.Builders is

   use CGK.Primitives.Directions_2D;
   use CGK.Primitives.Points_2D;
   use CGK.Primitives.XYs;
   use CGK.Reals;

   -----------
   -- Build --
   -----------

   procedure Build
     (Self    : in out Line_2D_Builder;
      Point_1 : CGK.Primitives.Points_2D.Point_2D;
      Point_2 : CGK.Primitives.Points_2D.Point_2D) is
   begin
      if Distance (Point_1, Point_2) >= Resolution then
         Self.Line :=
           Create_Line_2D
             (Point_1,
              Create_Direction_2D
                (Points_2D.XY (Point_2) - Points_2D.XY (Point_1)));
         Self.State := Valid;

      else
         Self.State := Confused_Points_Error;
      end if;
   end Build;

   -----------
   -- Build --
   -----------

   procedure Build
     (Self     : in out Line_2D_Builder;
      Line     : Line_2D;
      Distance : CGK.Reals.Real) is
   begin
      Self.Line :=
        Create_Line_2D
          (Create_Point_2D (Points_2D.XY (Location (Line))
             + Distance
                 * Create_XY (-Y (Direction (Line)), X (Direction (Line)))),
           Direction (Line));
      Self.State := Valid;
   end Build;

   ----------
   -- Line --
   ----------

   function Line (Self : Line_2D_Builder) return Line_2D is
   begin
      Assert_Invalid_State_Error (Self.State = Valid);

      return Self.Line;
   end Line;

end CGK.Primitives.Lines_2D.Builders;
