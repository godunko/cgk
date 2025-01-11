--
--  Copyright (C) 2023-2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Vector in 2D space.

with CGK.Primitives.Points_2D;
with CGK.Primitives.XYs;
with CGK.Reals;

package CGK.Primitives.Vectors_2D
  with Pure
is

   type Vector_2D is private;

   function As_Vector_2D (XY : CGK.Primitives.XYs.XY) return Vector_2D
     with Inline;

   function As_Vector_2D
     (X : CGK.Reals.Real; Y : CGK.Reals.Real) return Vector_2D;

   function Into_Vector_2D
     (Point_1 : CGK.Primitives.Points_2D.Point_2D;
      Point_2 : CGK.Primitives.Points_2D.Point_2D) return Vector_2D;
   --  Creates a vector from two points.

   function X (Self : Vector_2D) return CGK.Reals.Real with Inline;
   --  Returns X coordinate.

   function Y (Self : Vector_2D) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function XY (Self : Vector_2D) return CGK.Primitives.XYs.XY with Inline;
   --  Returns X and Y coordinates.

   function "-" (Self : Vector_2D) return Vector_2D with Inline;

   function "*"
     (Left : Vector_2D; Right : CGK.Reals.Real) return Vector_2D with Inline;
   --  Multiply vector by scalar.

   function "/"
     (Left : Vector_2D; Right : CGK.Reals.Real) return Vector_2D with Inline;
   --  Divide vector by scalar.

   function Magnitude (Self : Vector_2D) return CGK.Reals.Real with Inline;
   --  Returns magnitude of the vector.

   function Normal (Self : Vector_2D) return Vector_2D with Inline;
   --  Returns normal vector to given vector.

   function Dot (Self : Vector_2D; Other : Vector_2D) return CGK.Reals.Real
     with Inline;
   --  Scalar product of two vestors.

   function Cross (Self : Vector_2D; Other : Vector_2D) return CGK.Reals.Real
     with Inline;
   --  Cross product of two vectors.

private

   type Vector_2D is record
      Coordinates : CGK.Primitives.XYs.XY;
   end record;

   function As_Vector_2D (XY : CGK.Primitives.XYs.XY) return Vector_2D is
     (Coordinates => XY);

   function As_Vector_2D
     (X : CGK.Reals.Real; Y : CGK.Reals.Real) return Vector_2D is
       (Coordinates => CGK.Primitives.XYs.Create_XY (X, Y));

end CGK.Primitives.Vectors_2D;
