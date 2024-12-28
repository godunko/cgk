--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Cartesian coordinate entity in 3D space {X, Y, Z}

pragma Ada_2022;

with CGK.Mathematics.Vectors_3;
with CGK.Reals;

package CGK.Primitives.XYZs is

   pragma Pure;

   type XYZ is private;

   function As_XYZ
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return XYZ with Inline;

   function As_XYZ
     (Item : CGK.Mathematics.Vectors_3.Vector_3) return XYZ with Inline;

   function As_Vector_3
     (Self : XYZ) return CGK.Mathematics.Vectors_3.Vector_3 with Inline;

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

   type XYZ is new CGK.Mathematics.Vectors_3.Vector_3;

   function As_XYZ
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return XYZ is ([X, Y, Z]);

   function As_XYZ
     (Item : CGK.Mathematics.Vectors_3.Vector_3) return XYZ is (XYZ (Item));

   function As_Vector_3
     (Self : XYZ) return CGK.Mathematics.Vectors_3.Vector_3
        is (CGK.Mathematics.Vectors_3.Vector_3 (Self));

end CGK.Primitives.XYZs;
