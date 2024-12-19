--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Cartesian coordinate entity in 3D space {X, Y, Z}

with CGK.Reals;

package CGK.Primitives.XYZs is

   pragma Pure;

   type XYZ is private;

   function Create_XYZ
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return XYZ with Inline;

   procedure Set_XYZ
     (Self : out XYZ;
      X    : CGK.Reals.Real;
      Y    : CGK.Reals.Real;
      Z    : CGK.Reals.Real) with Inline;

   function X (Self : XYZ) return CGK.Reals.Real with Inline;
   --  Returns X coordinate.

   function Y (Self : XYZ) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function Z (Self : XYZ) return CGK.Reals.Real with Inline;
   --  Returns Z coordinate.

   function "+" (Left : XYZ; Right : XYZ) return XYZ with Inline;
   --  Sum components.

   function "-" (Left : XYZ; Right : XYZ) return XYZ with Inline;
   --  Subtract components.

private

   type XYZ is record
      X : CGK.Reals.Real := 0.0;
      Y : CGK.Reals.Real := 0.0;
      Z : CGK.Reals.Real := 0.0;
   end record;

end CGK.Primitives.XYZs;
