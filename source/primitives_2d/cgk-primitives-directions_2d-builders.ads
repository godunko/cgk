--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Advanced algorithms to create Direction_2D objects.

with CGK.Primitives.Points_2D;

package CGK.Primitives.Directions_2D.Builders is

   pragma Pure;

   type Direction_2D_Builder is private;

   procedure Build
     (Self : in out Direction_2D_Builder; XY : CGK.Primitives.XYs.XY);

   procedure Build
     (Self : in out Direction_2D_Builder;
      X    : CGK.Reals.Real;
      Y    : CGK.Reals.Real);

   procedure Build
     (Self : in out Direction_2D_Builder;
      From : CGK.Primitives.Points_2D.Point_2D;
      To   : CGK.Primitives.Points_2D.Point_2D);

   function Is_Valid (Self : Direction_2D_Builder) return Boolean with Inline;

   function Direction
     (Self : Direction_2D_Builder) return Direction_2D with Inline,
        Pre => Is_Valid (Self);

private

   type Direction_2D_Builder is record
      Valid  : Boolean := False;
      Result : Direction_2D;
   end record;

end CGK.Primitives.Directions_2D.Builders;
