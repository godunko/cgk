--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Direction - unit vector in the 3D space.

limited with CGK.Primitives.Vectors_3D;
with CGK.Primitives.XYZs;
with CGK.Reals;

package CGK.Primitives.Directions_3D is

   pragma Pure;

   type Direction_3D is private;

   function X (Self : Direction_3D) return CGK.Reals.Real with Inline;
   --  Returns X coordinate.

   function Y (Self : Direction_3D) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function Z (Self : Direction_3D) return CGK.Reals.Real with Inline;
   --  Returns Z coordinate.

   function XYZ
     (Self : Direction_3D) return CGK.Primitives.XYZs.XYZ with Inline;
   --  Returns XYZ triplet coordinate.

   function As_Vector_3D
     (Self : Direction_3D)
      return CGK.Primitives.Vectors_3D.Vector_3D with Inline;
   --  Convert Direction_3D to Vector_3D.

private

   type Direction_3D is record
      Coordinates : CGK.Primitives.XYZs.XYZ :=
        CGK.Primitives.XYZs.Create_XYZ (1.0, 0.0, 0.0);
   end record;

   procedure Unchecked_Set
     (Self : out Direction_3D;
      X    : CGK.Reals.Real;
      Y    : CGK.Reals.Real;
      Z    : CGK.Reals.Real);
   --  Sets components of the Direction_3D object. No checks or normalization
   --  done.

end CGK.Primitives.Directions_3D;
