--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Advanced algorithms to create Line_2D.

with CGK.Primitives.Points_2D;
with CGK.Reals;

package CGK.Primitives.Lines_2D.Builders is

   pragma Pure;

   type Line_2D_Builder is private;

   procedure Build
     (Self    : in out Line_2D_Builder;
      Point_1 : CGK.Primitives.Points_2D.Point_2D;
      Point_2 : CGK.Primitives.Points_2D.Point_2D);
   --  Make Line_2D that passing through two Point_2D.

   procedure Build
     (Self     : in out Line_2D_Builder;
      Line     : Line_2D;
      Distance : CGK.Reals.Real);
   --  Make Line_2D parallel to given line on given distance.

   function Line (Self : Line_2D_Builder) return Line_2D;
   --  Retuns constructed line.
   --
   --  @exception Invalid_State_Error

private

   type Line_2D_Builder is record
      State : CGK.Primitives.Builder_State_Kind := CGK.Primitives.Invalid;
      Line  : Line_2D;
   end record;

end CGK.Primitives.Lines_2D.Builders;
