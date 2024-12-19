--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Line in 2D space.

with CGK.Primitives.Axes_2D;
with CGK.Primitives.Directions_2D;
with CGK.Primitives.Points_2D;
with CGK.Reals;

package CGK.Primitives.Lines_2D is

   pragma Pure;

   type Line_2D is private;

   function Create_Line_2D
     (Axis : CGK.Primitives.Axes_2D.Axis_2D) return Line_2D with Inline;

   function Create_Line_2D
     (Point     : CGK.Primitives.Points_2D.Point_2D;
      Direction : CGK.Primitives.Directions_2D.Direction_2D)
      return Line_2D with Inline;

   function Location
     (Self : Line_2D) return CGK.Primitives.Points_2D.Point_2D with Inline;
   --  Returns location point (origin) of the line.

   function Direction
     (Self : Line_2D)
      return CGK.Primitives.Directions_2D.Direction_2D with Inline;
   --  Returns the direction of the line.

   procedure Coefficients
     (Self : Line_2D;
      A    : out CGK.Reals.Real;
      B    : out CGK.Reals.Real;
      C    : out CGK.Reals.Real) with Inline;
   --  Returns the normalized coefficients of the line.

private

   type Line_2D is record
      Axis : CGK.Primitives.Axes_2D.Axis_2D;
   end record;

end CGK.Primitives.Lines_2D;
