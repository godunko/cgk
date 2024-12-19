--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Direction - unit vector in the 2D space.

with CGK.Primitives.XYs;
with CGK.Reals;

package CGK.Primitives.Directions_2D is

   pragma Pure;

   type Direction_2D is private;

   function Create_Direction_2D
     (X : CGK.Reals.Real; Y : CGK.Reals.Real) return Direction_2D;

   function Create_Direction_2D
     (XY : CGK.Primitives.XYs.XY) return Direction_2D;

   function X (Self : Direction_2D) return CGK.Reals.Real with Inline;
   --  Returns X coordinate.

   function Y (Self : Direction_2D) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function XY (Self : Direction_2D) return CGK.Primitives.XYs.XY with Inline;
   --  Returns XY pair coordinate.

   function Is_Equal
     (Self              : Direction_2D;
      Other             : Direction_2D;
      Angular_Tolarance : CGK.Reals.Real) return Boolean;
   --  Returns True if two direction objects are equial with given angular
   --  tolerance.
   --
   --  @param Angular_Tolarance
   --    Maximum angle between equal direction objects.

private

   type Direction_2D is record
      Coordinates : CGK.Primitives.XYs.XY :=
        CGK.Primitives.XYs.Create_XY (1.0, 0.0);
   end record;

   procedure Unchecked_Set
     (Self : out Direction_2D;
      XY   : CGK.Primitives.XYs.XY);

end CGK.Primitives.Directions_2D;
