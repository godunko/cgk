--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Vector in 2D space.

with CGK.Primitives.Points_2D;
with CGK.Primitives.XYs;
with CGK.Reals;

package CGK.Primitives.Vectors_2D is

   pragma Pure;

   type Vector_2D is private;

   function Create_Vector_2D (XY : CGK.Primitives.XYs.XY) return Vector_2D
     with Inline;

   function Create_Vector_2D
     (X : CGK.Reals.Real; Y : CGK.Reals.Real) return Vector_2D;

   function Create_Vector_2D
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

end CGK.Primitives.Vectors_2D;
