--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Cartesian coordinate entity in 2D space {X, Y}

with CGK.Reals;
private with CGK.Mathematics.Vectors_2;

package CGK.Primitives.XYs is

   pragma Pure;

   type XY is private with Preelaborable_Initialization;

   function Create_XY
     (X : CGK.Reals.Real; Y : CGK.Reals.Real) return XY with Inline_Always;

   function X (Self : XY) return CGK.Reals.Real with Inline;
   --  Returns X coordinate.

   function Y (Self : XY) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function "+" (Left : XY; Right : XY) return XY with Inline;
   --  Sum components

   function "-" (Self : XY) return XY with Inline;

   function "-" (Left : XY; Right : XY) return XY with Inline;
   --  Subtract components

   function "*" (Left : XY; Right : CGK.Reals.Real) return XY with Inline;
   --  Multiply components by scalar.

   function "*" (Left : CGK.Reals.Real; Right : XY) return XY with Inline;
   --  Multiply components by scalar.

   function "/" (Left : XY; Right : CGK.Reals.Real) return XY with Inline;
   --  Divide components by scalar.

   function Modulus (Self : XY) return CGK.Reals.Real with Inline;
   --  Returns Sqrt (X * X + Y * Y)

   function Dot_Product
     (Self : XY; Other : XY) return CGK.Reals.Real with Inline;
   --  Returns scalar product of two vectors.

   function Cross_Product
     (Self : XY; Other : XY) return CGK.Reals.Real with Inline;
   --  Returns screw product of two vectors.

private

   type XY is new CGK.Mathematics.Vectors_2.Vector_2;

end CGK.Primitives.XYs;
