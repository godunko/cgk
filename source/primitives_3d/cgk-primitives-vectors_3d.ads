--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Vector in cartesian 3D space.

limited with CGK.Primitives.Points_3D;
with CGK.Primitives.XYZs;
with CGK.Reals;

package CGK.Primitives.Vectors_3D is

   pragma Pure;

   type Vector_3D is private;

   function Create_Vector_3D
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return Vector_3D with Inline;

   function Create_Vector_3D
     (XYZ : CGK.Primitives.XYZs.XYZ) return Vector_3D with Inline;

   function Create_Vector_3D
     (Point_1 : CGK.Primitives.Points_3D.Point_3D;
      Point_2 : CGK.Primitives.Points_3D.Point_3D) return Vector_3D;
   --  Creates a vector from two points.

   function X (Self : Vector_3D) return CGK.Reals.Real with Inline;
   --  Returns X coordinate.

   function Y (Self : Vector_3D) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function Z (Self : Vector_3D) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function XYZ (Self : Vector_3D) return CGK.Primitives.XYZs.XYZ with Inline;
   --  Returns XYZ triplet of coordinates.

   function "*"
     (Left : Vector_3D; Right : CGK.Reals.Real) return Vector_3D with Inline;

   function Cross
     (Left  : Vector_3D;
      Right : Vector_3D) return Vector_3D;
   --  Computes cross product of the vectors.

private

   type Vector_3D is new CGK.Primitives.XYZs.XYZ;

end CGK.Primitives.Vectors_3D;
